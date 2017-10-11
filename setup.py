from __future__ import print_function

import logging
from setuptools import setup
from distutils.extension import Extension
from Cython.Build import cythonize
import numpy
import cython_gsl


extensions = [
    Extension("fipy.gaussian", ["fipy/gaussian.pyx"],
        include_dirs=[numpy.get_include()], extra_compile_args=["-ffast-math",'-O3',"-march=native"])
]

setup_args = {'name':'fipy',
    'version':'0.0',
    'description':'A Python package for filtering with space-dependent kernels',
    'url':'https://github.com/bsafdi/fipy',
    'author':'Benjamin R. Safdi',
    'author_email':'bsafdi@umich.edu',
    'license':'MIT',
    'install_requires':[
            'numpy',
            'Cython'
        ]}

setup(packages=['fipy'],
    ext_modules = cythonize(extensions),
    **setup_args
)
print("Compilation successful!")
