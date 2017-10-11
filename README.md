# fipy

This code accomplishes the same action as `scipy.ndimage.filters.gaussian_filter1d` --- that is, it performs 1d filtering with a Gaussian kernel --- except that it allows for a variable array of sigma's the changes with position.

## Compiling and Running

This code package is written in `python` and `cython`. The easiest way to install `fipy`, along with it's dependent Python packages, is to use the setup script:

```
python setup.py install
```

To just compile the cython modules locally:

```
make build
```

## Examples

An example of Gaussian smoothing is provided in the `examples/` directory.


