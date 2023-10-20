# Podman Run Action

- forked from https://github.com/addnab/docker-run-action
- run a specific step in podman.
- run an image built by a previous step.
- See https://github.com/fmidev/podman-run-action/blob/main/action.yml for all the available inputs.

## Examples

#### Typical Use Case

```yaml
- name: Checkout 
  uses: actions/checkout@v2 # Required to mount the Github Workspace to a volume 
- uses: fmidev/podman-run-action@v1
  with:
    username: ${{ secrets.PODMAN_USERNAME }}
    password: ${{ secrets.PODMAN_PASSWORD }}
    registry: gcr.io
    image: private-image:latest
    options: -v ${{ github.workspace }}:/work -e ABC=123
    run: |
      echo "Running Script"
      /work/run-script
```

#### run a privately-owned image
```yaml
- uses: fmidev/podman-run-action@v1
  with:
    username: ${{ secrets.PODMAN_USERNAME }}
    password: ${{ secrets.PODMAN_PASSWORD }}
    registry: gcr.io
    image: test-image:latest
    run: echo "hello world"
```

#### run an image built by a previous step
```yaml
- uses: podman/build-push-action@v2
  with:
    tags: test-image:latest
    push: false
- uses: fmidev/podman-run-action@v1
  with:
    image: test-image:latest
    run: echo "hello world"
```


#### use a specific shell (default: sh). 
*Note: The shell must be installed in the container*
```yaml
- uses: fmidev/podman-run-action@v1
  with:
    image: podman:latest
    shell: bash
    run: |
      echo "first line"
      echo "second line"
```
