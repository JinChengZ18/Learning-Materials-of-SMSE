# Atomsk

Atom/Molecule/Material Software Kit

© Pierre Hirel 2010 - Version Beta-0.10.6

## Contents:

1. [License - Read first!](https://atomsk.univ-lille.fr/doc/en/license.html)
2. [Overview - Quick start](https://atomsk.univ-lille.fr/doc/en/overview.html)
3. [Examples](https://atomsk.univ-lille.fr/doc/en/examples.html)
4. [Compilation and installation](https://atomsk.univ-lille.fr/doc/en/install.html)
5. [Supported file formats](https://atomsk.univ-lille.fr/doc/en/formats.html)
6. Options
   - [add-atom](https://atomsk.univ-lille.fr/doc/en/option_addatom.html) - Insert one or more new atoms
   - [add-shells](https://atomsk.univ-lille.fr/doc/en/option_addshells.html) - Create shells for some or all atoms
   - [alignx](https://atomsk.univ-lille.fr/doc/en/option_alignx.html) - Align the first cell vector with the X axis
   - [bind-shells](https://atomsk.univ-lille.fr/doc/en/option_bindshells.html) - Re-associate shells with their core
   - [center](https://atomsk.univ-lille.fr/doc/en/option_center.html) - Shift the system at the center of the box
   - [crack](https://atomsk.univ-lille.fr/doc/en/option_crack.html) - Insert a crack in the system
   - [cut](https://atomsk.univ-lille.fr/doc/en/option_cut.html) - Wipe out part of the system
   - [deform](https://atomsk.univ-lille.fr/doc/en/option_deform.html) - Apply unidirectional stress or strain to the system
   - [dislocation](https://atomsk.univ-lille.fr/doc/en/option_disloc.html) - Insert a dislocation in the system
   - [disturb](https://atomsk.univ-lille.fr/doc/en/option_disturb.html) - Randomly move atoms out of their positions
   - [duplicate](https://atomsk.univ-lille.fr/doc/en/option_duplicate.html) - Duplicate the system, construct supercells
   - [fix](https://atomsk.univ-lille.fr/doc/en/option_fix.html) - Fix the coordinates of some atoms
   - [fractional](https://atomsk.univ-lille.fr/doc/en/option_fractional.html) - Convert to reduced coordinates
   - [mirror](https://atomsk.univ-lille.fr/doc/en/option_mirror.html) - Apply a mirror transformation
   - [options](https://atomsk.univ-lille.fr/doc/en/option_options.html) - Apply options read from a file
   - [orient](https://atomsk.univ-lille.fr/doc/en/option_orient.html) - Change the crystallographic orientation of the system
   - [orthogonal-cell](https://atomsk.univ-lille.fr/doc/en/option_orthocell.html) - Find a suitable equivalent orthogonal cell
   - [properties](https://atomsk.univ-lille.fr/doc/en/option_properties.html) - Set properties of the system
   - [rebox](https://atomsk.univ-lille.fr/doc/en/option_rebox.html) - Try to guess supercell parameters
   - [remove-atom](https://atomsk.univ-lille.fr/doc/en/option_rmatom.html) - Remove one or several atoms
   - [remove-doubles](https://atomsk.univ-lille.fr/doc/en/option_rmd.html) - Remove duplicate atoms
   - [remove-property](https://atomsk.univ-lille.fr/doc/en/option_rmprop.html) - Remove one or all auxiliary properties
   - [remove-shells](https://atomsk.univ-lille.fr/doc/en/option_rmshells.html) - Remove shells on some or all atoms
   - [roll](https://atomsk.univ-lille.fr/doc/en/option_roll.html) - Bend or roll the system around an axis
   - [rotate](https://atomsk.univ-lille.fr/doc/en/option_rotate.html) - Rotate the system around an axis
   - [select](https://atomsk.univ-lille.fr/doc/en/option_select.html) - Select atoms according to a criterion
   - [separate](https://atomsk.univ-lille.fr/doc/en/option_separate.html) - Pull apart atoms that are too close
   - [shear](https://atomsk.univ-lille.fr/doc/en/option_shear.html) - Shear the system
   - [shift](https://atomsk.univ-lille.fr/doc/en/option_shift.html) - Shift part of the system
   - [sort](https://atomsk.univ-lille.fr/doc/en/option_sort.html) - Change the order in which atoms are written
   - [spacegroup](https://atomsk.univ-lille.fr/doc/en/option_spacegroup.html) - Apply symmetry operations of a space group
   - [stress](https://atomsk.univ-lille.fr/doc/en/option_stress.html) - Apply stress to the system
   - [substitute](https://atomsk.univ-lille.fr/doc/en/option_substitute.html) - Replace atoms by other atoms
   - [swap](https://atomsk.univ-lille.fr/doc/en/option_swap.html) - Swap atoms or Cartesian axes
   - [torsion](https://atomsk.univ-lille.fr/doc/en/option_torsion.html) - Apply torsion along an axis
   - [unit](https://atomsk.univ-lille.fr/doc/en/option_unit.html) - Change the unit of coordinates
   - [unskew](https://atomsk.univ-lille.fr/doc/en/option_unskew.html) - Reduce the skew of the box
   - [velocity](https://atomsk.univ-lille.fr/doc/en/option_velocity.html) - Create a Maxwell-Boltzmann distribution of velocities
   - [wrap](https://atomsk.univ-lille.fr/doc/en/option_wrap.html) - Wrap atoms back into the box
7. Modes (click for more)
   - [All-in-one](https://atomsk.univ-lille.fr/doc/en/mode_allinone.html) - Convert several files to one file containing all snapshots
   - [Average](https://atomsk.univ-lille.fr/doc/en/mode_average.html) - Average atom positions over several configurations
   - [Create](https://atomsk.univ-lille.fr/doc/en/mode_create.html) - Create a system from scratch
   - [ddplot](https://atomsk.univ-lille.fr/doc/en/mode_ddplot.html) - Create a file for visualization with the ddplot program
   - [List](https://atomsk.univ-lille.fr/doc/en/mode_filelist.html) - Convert all files in a list
   - [Help](https://atomsk.univ-lille.fr/doc/en/mode_help.html) - Displays help
   - [Interactive](https://atomsk.univ-lille.fr/doc/en/mode_interactive.html) - Manipulate systems interactively or with scripts
   - [Interpolate](https://atomsk.univ-lille.fr/doc/en/mode_interpolate.html) - Interpolates atom positions between two configurations
   - [Merge](https://atomsk.univ-lille.fr/doc/en/mode_merge.html) - Merge two or more systems into one
   - [Normal](https://atomsk.univ-lille.fr/doc/en/mode_normal.html) - Convert a file to one or many formats
   - [One-in-all](https://atomsk.univ-lille.fr/doc/en/mode_oneinall.html) - Convert one file containing several snapshots to several files
   - [Polycrystal](https://atomsk.univ-lille.fr/doc/en/mode_polycrystal.html) - Create a polycrystal using Voronoi method
   - [Unwrap](https://atomsk.univ-lille.fr/doc/en/mode_unwrap.html) - Unwrap atom coordinates
8. Program behaviour
   - [ignore](https://atomsk.univ-lille.fr/doc/en/progbe_ig.html) - Always ignore existing files
   - [language](https://atomsk.univ-lille.fr/doc/en/progbe_lang.html) - Set language of messages
   - [logfile](https://atomsk.univ-lille.fr/doc/en/progbe_log.html) - Set up log file name
   - [overwrite](https://atomsk.univ-lille.fr/doc/en/progbe_ow.html) - Always overwrite existing files
   - [verbosity](https://atomsk.univ-lille.fr/doc/en/progbe_verb.html) - Set verbosity level
9. [Companion tools](https://atomsk.univ-lille.fr/doc/en/tools.html)
10. [Acknowledgements](https://atomsk.univ-lille.fr/doc/en/acknowledgements.html)
11. [FAQ - Frequently Asked Questions](https://atomsk.univ-lille.fr/doc/en/faq.html)
12. [Information for developers](https://atomsk.univ-lille.fr/doc/en/developers.html)
13. [Contact](https://atomsk.univ-lille.fr/doc/en/contact.html)
14. [Other useful codes](https://atomsk.univ-lille.fr/doc/en/othercodes.html)
