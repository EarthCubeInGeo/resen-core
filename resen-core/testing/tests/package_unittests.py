# package_unittests.py
# script to automatically run unit tests of all packages installed in resen-core
# currently only works for python3

import sys
import os
import inspect
import urllib.request
import pytest
import unittest
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
    # clean up
    shutil.rmtree('./cartopy_test_output')

def cryptography_test():
    pass

def cython_test():
    # this takes forever - not yet validated that it does anything useful
#     print('CYTHON TEST')
#     # get test scripts
#     os.system("svn checkout https://github.com/cython/cython/trunk/tests")
#     # run tests
#     pytest.main(['./tests'])
#     # clean up by removing test scripts
#     shutil.rmtree('./tests')
        pass

def davitpy_test():
    # can't find any standard tests
    pass

def h5py_test():
    print('H5PY TEST')
    import h5py
    h5py.run_tests()

def ipython_test():
    # not sure what to do about this one
    pass

def mangopy_test():
    # unit tests do not exist yet
    pass

def matplotlib_test():
    # You may need to install matplotlib from source to run these tests, which kind of defeats the purpose of testing our installation
#     print('MATPLOTLIB TEST')
#     import matplotlib
#     matplotlib.test()
    pass

def mechanize_test():
    # tests may be available to download from github
    pass

def nbformat_test():
    print('NBFORMAT TEST')
    pytest.main(['--pyargs', 'nbformat'])
#     pass

def netCDF4_test():
    print('NETCDF4 TEST')
    # get test scripts
    os.system("svn checkout https://github.com/Unidata/netcdf4-python/trunk/test")    
    # run tests
    os.system("cd test && python -m unittest discover . 'tst*py' && cd ..")        
    # clean up by removing test scripts
    shutil.rmtree('./test')
#     pass

def numpy_test():
    print('NUMPY TEST')
    import numpy
    numpy.test()

def pandas_test():
    print('PANDAS TEST')
    # requires hypothesis installed
    pytest.main(['--pyarg', 'pandas'])
#     pass

def paramiko_test():
    print('PARAMIKO TEST')
    # get test scripts
    os.system("svn checkout https://github.com/paramiko/paramiko/trunk/tests")
    # run tests
    pytest.main(['./tests'])
    # clean up by removing test scripts
    shutil.rmtree('./tests')
#     pass

def pyglow_test():
    # unit tests require installation from source
    pass

def pymongo_test():
    # potentially requires a special pytest plugin? (https://pypi.org/project/pytest-mongodb/)
    pass

def pytest_test():
    # unknown how to do this - use pytest to test pytest?
    pass

def pytz_test():
    # can't find a standard test suite
    pass

def scipy_test():
    print('SCIPY TEST')
    import scipy
    scipy.test()
    # clean up
    os.remove('gramA')
    os.remove('gramB')

def sciunit2_test():
    # unit tests appear to be available (https://github.com/scidash/sciunit/tree/dev/sciunit/unit_test) but can't find source in bucket file system
    pass

def sgp4_test():
    print('SGP4 TESTS')
    pytest.main(['--pyargs', 'sgp4.tests'])

def spacepy_test():
    # doesn't seem to work - error collecting tests
#     print('SPACEPY TEST')
#     # get test scripts
#     os.system("svn checkout https://github.com/spacepy/spacepy/trunk/tests")
#     # run tests
#     pytest.main(['./tests'])
#     # clean up by removing test scripts
#     shutil.rmtree('./tests')
    pass

def sqlalchemy_test():
    # may also require a special plug-in (https://pypi.org/project/pytest-flask-sqlalchemy/)
    pass

def sympy_test():
    print('SYMPY TEST')
    import sympy
    sympy.test('_basic')
#     # more thorough but slower
#     sympy.test('/core', '/util')
#     # full functionality (impractically slow)
#     sympy.test()
#     pass

def tables_test():
    print('TABLES TEST')
    import tables
    tables.test()
#     pass

def yaml_test():
    # source code for yaml also is supposed to contain a test suite - not sure how to access this though
    pass

    
if __name__=='__main__':
    test_functions = inspect.getmembers(sys.modules[__name__], inspect.isfunction)
    for name, test in test_functions:
        test()
