# Distro-cl

This is a version of Soumith's [distro](https://github.com/torch/distro) for using OpenCL

It is essentially Torch as of ~21 February, plus cltorch, and clnn, to enable OpenCL.

## Why create a distro for OpenCL?

The advantage of installing OpenCL from a fixed distro like this is I can control very precisely what and
when gets ported from torch.  Otherwise, I get emails about clnn being broken, at 4am on a Monday morning,
and I do have a full-time day-job, so I cannot fix everything straight away :-D  By using a specific
distro, I can eat changes from upstream as and when they become useful/important/someone requests them
in a issue.

## How to install?

* see [cltorch](https://github.com/hughperkins/cltorch) page for installation instructions.  It is
quite easy :-)

## Wont this be behind main Torch bleeding edge?

Yes.  But hopefully stable.  And working.  Please file an issue for any features you want from upstream.

## Can I use `cunn` and `cutorch` from this distro?

Yes

## Do you support ubuntu 16.04?

Yes.  I am running Ubuntu 16.04 :-)

## How to request new features, or pull new features from upstream?

Please file an issue.

