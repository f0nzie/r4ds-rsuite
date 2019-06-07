# r4ds-rsuite

<!-- badges: start -->
<!-- badges: end -->

The goal of `r4ds-rsuite` is providing an update resistant version of the book by installing `r4ds` in its own environment, with its own packages, frozen at a time of your chosing.

I have cloned `r4ds` on June 6, 2019, and immediately added a package under the folder packages called `r4ds.book.pkgs`. This package contains all the packages required by `r4ds` so it can run independently from the global environment.

To be able to do this, we use [rsuite](https://rsuite.io/), an application with a client (Windows, Linux and Mac), a package `RSuite`, and a RStudio addin. The application is open source and is available in Github.

I have been converting the most important and complex of my project to `rsuite` administered form. It really is a time saver because the dependencies or packages do not break after doing an update.

## How to use this `r4ds` variation

1. Download and install the `rsuite` client in your machine.
2. Install the R package with `rsuite install`
3. Clone this repo
4. From the project root `r4ds-rsuite`, open a terminal, and run 
`Rscript R/compile_book.R`. The book will start building.
5. Run the bookdown or `gitbook` version of `r4ds` by running `index.html` under the folder `work/r4ds/_book`

You will notice that the folder `deployment/libs` has been populated only by the packages required by `r4ds`. The operation is the same for any of the operating systems. The R binaries are generated depending of the OS.

## Project deployment
I like the idea behind `rsuite`. What I showed above is only of the things that you can do with it. Additionally, you can:

1. Put several packages under a main umbrella project to manage all of them, including tests and builds.
2. Generate a stand-alone Python from Anaconda inside the `rsuite` project. This is a pretty neat idea for distributing ready-to-run applications, because if you share with other users, they don't even need to install Python; only R is needed.
3. Create a local copy of a whole remote repository, for instance CRAN, or selected packages, in you own server, Amazon instance, or your local drive.
4. Build a distributable R application as a zip file, where your users don't need to install any packages. Unpack it and run it with R.
5. You can also deploy the R application within a Docker container as well. So, instead of sending to your users a zip file, you send them a link to download a Docker container including R itself.
6. There feqw other things that `rsuite` does but haven't tested or explored yet. But the whole concept is pretty neat, preparing you for deployment.


## References

* [rsuite in Github](https://github.com/WLOGSolutions/RSuite)
* [rsuite website](https://rsuite.io/)
* [r4ds-rsuite](https://github.com/f0nzie/r4ds-rsuite)






