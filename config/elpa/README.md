# ELPA<a name="eigenvalue-solvers-for-petaflop-applications-elpa"></a>

## Build Instructions

### ELPA 2018.05.001 and 2018.11.001

[Download](http://elpa.mpcdf.mpg.de/elpa-tar-archive) and unpack ELPA and make the configure wrapper scripts available in ELPA's root folder. It is recommended to package the state (Tarball or similar), which is achieved after downloading the wrapper scripts.

**NOTE**: both 2018-versions **fail or crash in several regression tests** in CP2K (certain rank-counts produce an incorrect decomposition), and hence they should be avoided in production with CP2K or Quantum Espresso (QE).

```bash
wget https://elpa.mpcdf.mpg.de/html/Releases/2018.05.001/elpa-2018.05.001.tar.gz
tar xvf elpa-2018.05.001.tar.gz
cd elpa-2018.05.001
wget --no-check-certificate https://github.com/hfp/xconfigure/raw/master/configure-get.sh
chmod +x configure-get.sh
./configure-get.sh elpa
```

Please make the Intel Compiler and Intel&#160;MKL available on the command line. This depends on the environment. For instance, many HPC centers rely on `module load`.

```bash
source /opt/intel/compilers_and_libraries_2018.3.222/linux/bin/compilervars.sh intel64
```

For example, to configure and make for an Intel Xeon Scalable processor ("SKX"):

```bash
make clean
./configure-elpa-skx-omp.sh
make -j ; make install

make clean
./configure-elpa-skx.sh
make -j ; make install
```

After building and installing the desired configuration(s), one may have a look at the installation:

```bash
[user@system elpa-2018.05.001]$ ls ../elpa
 default-skx
 default-skx-omp
```

For different targets (instruction set extensions) or for different versions of the Intel Compiler, the configure scripts support an additional argument ("default" is the default tagname):

```bash
./configure-elpa-skx-omp.sh tagname
```

As shown above, an arbitrary "tagname" can be given (without editing the script). This might be used to build multiple variants of the ELPA library.

### ELPA 2017.11.001 (and older)

[Download](http://elpa.mpcdf.mpg.de/elpa-tar-archive) and unpack ELPA and make the configure wrapper scripts available in ELPA's root folder. It is recommended to package the state (Tarball or similar), which is achieved after downloading the wrapper scripts.

**NOTE**: this version of ELPA must be used with Quantum Espresso's __ELPA_2018 interface (`-D__ELPA_2018`), which is patched into QE by default when using XCONFIGURE's up-to-date build wrapper scripts. The __ELPA_2017 preprocessor definition triggers the ELPA1 legacy interface (get_elpa_row_col_comms, etc.), which was removed after [ELPA&#160;2017.05.003](#elpa-201705003). Also, it appears `make clean` (or similar Makefile target) for ELPA 2016.11.001 is cleaning up the entire directory including all "non-ELPA content" (the directory also remains somewhat unclean such that subsequent builds may fail)

```bash
wget https://elpa.mpcdf.mpg.de/html/Releases/2017.11.001/elpa-2017.11.001.tar.gz
tar xvf elpa-2017.11.001.tar.gz
cd elpa-2017.11.001
wget --no-check-certificate https://github.com/hfp/xconfigure/raw/master/configure-get.sh
chmod +x configure-get.sh
./configure-get.sh elpa
```

Please make the Intel Compiler and Intel&#160;MKL available on the command line. This depends on the environment. For instance, many HPC centers rely on `module load`.

```bash
source /opt/intel/compilers_and_libraries_2018.3.222/linux/bin/compilervars.sh intel64
```

For example, to configure and make for an Intel Xeon Scalable processor ("SKX"):

```bash
make clean
./configure-elpa-skx-omp.sh
make -j ; make install

make clean
./configure-elpa-skx.sh
make -j ; make install
```

### ELPA Development

To rely on experimental functionality, one may git-clone ELPA's master branch instead of downloading a regular version.

```bash
git clone --branch ELPA_KNL https://gitlab.mpcdf.mpg.de/elpa/elpa.git
```

To build ELPA, the instructions for building the latest release should apply as well.

## References

[https://software.intel.com/en-us/articles/quantum-espresso-for-the-intel-xeon-phi-processor](https://software.intel.com/en-us/articles/quantum-espresso-for-the-intel-xeon-phi-processor)

