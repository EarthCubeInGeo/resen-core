# package_unittests.py
# script to automatically run unit tests of all packages installed in resen-core
# currently only works for python3

import sys
import os
import inspect
import urllib.request
import pytest
import shutil

def apexpy_test():
    print('APEXPY TEST')
    # collect test scripts from github (there's probably a better way to just download the entire tests directory)
    baseurl = 'https://raw.githubusercontent.com/aburrell/apexpy/master/tests/'
    os.mkdir('./tests')
    test_scripts = ['test_Apex.py', 'test_cmd.py', 'test_convert.txt', 'test_convert_single_line.txt', 'test_fortranapex.py', 'test_helpers.py']
    for script in test_scripts:
        urllib.request.urlretrieve(baseurl+script, './tests/'+script)

    # run tests
    pytest.main(['./tests'])
    
    # clean up by removing test scripts
    shutil.rmtree('./tests')

def bokeh_test():
    print('BOKEH TEST')
    pytest.main(['--pyargs', '-m', 'unit', 'bokeh.tests'])

def bsddb3_test():
    pass

def cartopy_test():
    print('CARTOPY TEST')
    ## NOTE: Requires filelock
    pytest.main(['--pyargs', 'cartopy.tests'])

def cryptography_test():
    pass

def cython_test():
    pass

def davitpy_test():
    pass

def h5py_test():
    print('H5PY TEST')
    import h5py
    h5py.run_tests()

def ipython_test():
    pass

def mangopy_test():
    pass

def matplotlib_test():
    pass

def mechanize_test():
    pass

def nbformat_test():
    pass

def netCDF4_test():
    pass

def numpy_test():
    print('NUMPY TEST')
    import numpy
    numpy.test()

def pandas_test():
    pass

def paramiko_test():
    pass

def pyglow_test():
    pass

def pymongo_test():
    pass

def pytest_test():
    pass

def pytz_test():
    pass

def scipy_test():
    print('SCIPY TEST')
    import scipy
    scipy.test()

def sciunit2_test():
    pass

def sgp4_test():
    print('SGP4 TESTS')
    pytest.main(['--pyargs', 'sgp4.tests'])

def spacepy_test():
    pass

def sqlalchemy_test():
    pass

def sympy_test():
    pass

def tables_test():
    pass

def yaml_test():
    pass

    
if __name__=='__main__':
    test_functions = inspect.getmembers(sys.modules[__name__], inspect.isfunction)
    for name, test in test_functions:
        test()
