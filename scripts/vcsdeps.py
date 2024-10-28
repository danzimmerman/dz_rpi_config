#!/bin/python3
import io
import os
import pathlib
import requests
import yaml

packages = input().strip().split()
ros_distro = os.environ["ROS_DISTRO"]
rd_yaml_url = f"https://raw.githubusercontent.com/ros/rosdistro/refs/heads/master/{ros_distro}/distribution.yaml"
print(f"***Looking for {ros_distro} package repos at\n\t{rd_yaml_url}")

req = requests.get(rd_yaml_url)
with io.StringIO(req.text) as ymf:
    all_repo_info = yaml.safe_load(ymf)

# get a lookup map from package -> repository when available
package_lookup = {}
for repo_key, repo_info in all_repo_info["repositories"].items():
    # print(repo_info)
    try:
        relinfo = repo_info["release"]
        if "packages" in relinfo.keys():
            for pkg in relinfo["packages"]:
                package_lookup[pkg] = repo_key
        else:
            package_lookup[repo_key] = repo_key
    except KeyError as e:
        pass


system_packages = []
ros_packages = {}
ros_repo_data = {}
for pkg in packages:
    if pkg in package_lookup.keys():
        repo_key = package_lookup[pkg]
        # don't duplicate repositories we already added
        if not repo_key in ros_repo_data.keys():
            # print(repo_key)
            src_data = all_repo_info["repositories"][repo_key]["source"]
            try:
                _ = src_data.pop("test_pull_requests")
            except:
                pass
            ros_repo_data[f"src/{repo_key}"] = src_data

        # keep a list of packages that comes from each repo
        if not repo_key in ros_packages.keys():
            ros_packages[repo_key] = []
            ros_packages[repo_key].append(pkg)
        else:
            ros_packages[repo_key].append(pkg)

    else:
        system_packages.append(pkg)


repos_filename = pathlib.Path("./ws_deps.repos").absolute()
print(f"Writing {repos_filename.as_posix()}")
with repos_filename.open("w") as rpf:
    rpf.write(yaml.dump({"repositories": ros_repo_data}))

print("System Package Installation")
pkgstr = " ".join(system_packages)
print(f"sudo apt install {pkgstr}")
