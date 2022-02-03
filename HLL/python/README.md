# Running Python on Hoffman2

This is a quick guide on running Python applications on Hoffman2

## Intro

Hoffman2 supports running Python applications. It is **HIGHLY** recommended to use a version of python that has been built and tested by Hoffman2 staff. These versions of python can be accessed by using `module load` commands. This means that using system python builds (i.e. /usr/bin/python) are **NOT** recommended and using `modules` are needed before you run Python.

For example:

```
module load python/3.7.3
which python3
```

This example will load the python version 3.7.3 into your env and then output the directory location of python. As you see, it located at `/u/local/apps/python/3.7.3/gcc-4.8.5/bin/python3`, which is the correct location of this version of python so we can see that we are setup to use python.

To see more version of Python supported on Hoffman2, run `module av python`. This will show all version of python that the Hoffman2 staff have installed.

The python that is install by Hoffman2 staff is build from source and is located in the Hoffman2 main apps directory to maintain multiple versions

## Package installation 

The builds of Python on Hoffman2 **ONLY** have the basic compiler/interpreter and a few basic packages. 

Most python application will need to install packages to run. Popular Python packages/APIs have been, Pandas, SciPy, Scikit-learn, and TensorFlow, to name a few. Unfortunately, Hoffman2 staff do **NOT** install packages into the python builds that are supported. Users are also not able to install packages/app in the python build directories. This is because of packages of different versions can cause conflicts with other package dependencies, causing Python to break and unusable. 

While users do not install packages into the main Python build directories, users may install packages into their own directories ($HOME, $SCRATCH, or any Project directories). There are a few ways a user can accomplish this.

- Using pip package manager
- Using Python Virtual Environments
- Using anaconda


You can also install packages from source. These are examples of using package managers on Hoffman2.

### Using pip package manager

If you would like to use the package, scikit-learn, you can install this package via the pip (PyPI) package manager. 

```
module load python/3.7.3
pip3 install scikit-learn --user
```

You will notice the `--user` flag on `pip3`. Is will ensure that you will install the package in your $HOME directory. Normally, pip will try to install in the main Python build, in which, users do not have write access and you may see errors when building your package. When using `--user` by deafult, it will install it in `$HOME/.local/lib/python3.7/site-packages`. 

If you want to install this package in another directory (Maybe you $HOME quota is filling up), you can install this package in any directory you have write access. For example, if you want to install this package in `$SCRATCH/python-pkg`,

```
module load python/3.7.3
pip3 install scikit-learn -t $SCRATCH/python-pkg
export PYTHONPATH=$SCRATCH/python-pkg:$PYTHONPATH
```

When running your jobs, will will have to make sure that the variable `$PYTHONPATH` is updated to have any custom locations of your packages.

### Python Virtual Environments

One great way to manage your Python packages is using Python's Virtual Environment feaure. This will allow users to install and manage Python inside an environment that they control and is located in their own directories. It is an isolated runtime environment so user can set unqiue versions and dependencies of applications. This is good when you are running multiple applications that requires different application enironments.

To create a environment, you will first load the base Python version on Hoffman2 you want to use. For example, if you want to use python/3.7.3:

```
module load python/3.7.3
```

Then create a directory location you want to install the env.

```
mkdir -pv $HOME/myenv
python3 -m venv $HOME/myenv/mypython3.7.3
```

This will create an env named **mypython3.7.3**. Once it is created, you can activate the env by:

```
source $HOME/myenv/mypython3.7.3/bin/activate
```

This is a bash shell script that will active your new python environment. From here, you can managing packages with pip or and other installtion method. 

Since this is a new, custom python env that you created, you don't need to add `--user` flags in pip. All new libraries and packages will be installed by default to `$HOME/myenv/mypython3.7.3` or wherever you had your new virtual env created.

More information about using Python Virtual Environments can be found here https://docs.python.org/3/tutorial/venv.html

### Anaconda

Anaconda is a very popular Python (and R) distribution. This is a great option for simplifing package management and piplines. Hoffman2 does have Anaconda installed, from which, the user can create their own conda environments.

TO create a environment, you will first need to load the Anaconda module 

```
module load anaconda3/2020.11
. $CONDA_DIR/etc/profile/conda.sh
```

This is load anaconda. BTW, there is NO need to load a python module, since you will create and run python in your local environment.

**NOTE** There is NO need to run `conda init`. Anaconda is environment is already load when you run the `conda.sh` script. When you run `conda init`, it will modify your `.bashrc` file and possibly break your created env.

After you load anaconda, you wil now create your new environment

```
conda create --name mypython3.7 python=3.7
conda activate mypython3.7
```

This will create a python env, version 3.7, with the name `mypython3.7`. Then it will activate the new environment. From here you can install any package you want with `conda install` or `pip install`. 

```
conda activate mypython3.7
conda install scipy=0.15.0
```

By default, conda envs are install in `$HOME/.conda` directories. You can create env in other directories by 

```
conda create -p $SCRATCH/mypython python=3.7
conda active $SCRATCH/mypython
```

This will install the conda env in a custom location. You can install your conda env in a shared (PROJECT) directory so they can be shared with other users.


## Examples


