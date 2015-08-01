# alpine-node

Nodejs + Alpine for Rocket ACI conversion.

    FROM nowk/alpine-base:3.2


| Stats             |         |
| ----------------- | ------- |
| Docker Image Size | ~42 MB  |
| Rocket ACI Size   | ~17 MB  |

---

`ENV` variables

    NODE_MAJOR 0.12
    NODE_VERSION 0.12.2
    NPM_VERSION 2.7.4

---

__Converting:__

    docker2aci docker://nowk/alpine-node:0.12.2

*Latest version of the actool will properly export the LABEL directives defined 
in the Dockerfile, else please read below.*

Because the `arch` label is not exported, we will need to add that in manually 
by extracting, modifying the manifest then rebuilding the ACI before adding to
our image store.

    tar xvf nowk-alpine-node-0.12.2.aci -C alpine-node

Add the `arch` label.

    ...
    "labels": [
        ...
        {
            "name": "arch",
            "value": "amd64"
        },
        ...
    ],
    ...

Rebuild the ACI.

    actool build --overwrite alpine-node alpine-node-0.12.2-linux-amd64.aci

Add to the image store via `rkt fetch`.

    sudo rkt --insecure-skip-verify fetch alpine-node-0.12.2-linux-amd64.aci

__Add as a dependency:__

In your app's ACI `manifest`.

    ...
    "dependencies": [
        {
            "imageName": "nowk/alpine-node",
            "labels": [
                {
                    "name": "version",
                    "value": "0.12.2",
                },
                {
                    "name": "os",
                    "value": "linux",
                },
                {
                    "name": "arch",
                    "value": "amd64",
                }
            ]
        }
    ],
    ...

__Nodejs binary:__

The node binary is located at:

    /usr/bin/node

The npm binary is located at:

    /usr/bin/npm
