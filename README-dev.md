# Developer's notes for c756 quickies

These files are defined to be used in both host OS and
c756-exer tools container configurations.

The following scripts simplify the development process.

## `xfer.sh`:  Transfer files to `c756-exer`

After modifying any of these files, run `xfer.sh`to transfer the
updated files into the `profiles` subdirectory of the `c756-exer` repo.
Then commit the updated files to `c756-exer` as well.

Note that `xfer.sh` does more than simply copy the files:  It also
modifies their settings to match the different environment in `c756-exer`.

## `fixup.sh`: Automatically edit `.ec2.mak` to your settings

The utility `fixup.sh` can be used when revising `.ec2.mak`.  The committed
revisions have to have empty values for variables such as `SGI_WFH`, yet
when running tests you need your actual values set.

To get around this, edit `fixup.sh` to include your settings for `SGI_SFH`,
`KEY`, and `LKEY`.  Then, after editing `.ec2.mak`, commit the file
with empty values, then run `fixup.sh` to set the values correctly for
your use.  Then test the file with these correct values.