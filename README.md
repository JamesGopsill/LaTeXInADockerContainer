# LaTeX in a Docker Container

This repo contains the Dockerfile I use to create a LaTeX runtime that can be used across different OS's and enables me to stay up to date with the latest releases without having to delete old TexLive instances on the main OS.

To build, open a terminal at the top-level of this repo and run:

```
docker build -t latex .
```

Note: this will take some time as it installs texlive-full into the image. If your demands are less that just go into the Dockerfile and change the texlive package to the one you wish to install.

Custom fonts can be added in by placing them in the accompanying fonts folder.

To compile latex files on the host machine, simply run

```
docker run -v $PWD:/latex:delegated --rm latex 
```

in the directory of your LaTeX document.

Note: the container assumes that the entry to the LaTeX document is `main.tex` and it runs XeLaTeX. All of which can be customised or generalised.

I also use VSCode for writing LaTeX documents using the LaTeX Workshop extension. Below is the recipe that can be used to configure LaTeX Workshop to use LaTeX in the docker container.

```
"latex-workshop.latex.recipes": [
	{
		"name": "docker",
		"tools": [
			"docker"
		]
	}
]

"latex-workshop.latex.tools": [
	{
		"name": "docker",
		"command": "docker",
		"args": [
			"run",
			"-v",
			"%DIR%:/latex:delegated",
			"--rm",
			"latex"
		]
	}
]
```