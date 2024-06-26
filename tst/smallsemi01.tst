# Smallsemi, chapter 3
#
# DO NOT EDIT THIS FILE - EDIT EXAMPLES IN THE SOURCE INSTEAD!
#
# This file has been generated by AutoDoc. It contains examples extracted from
# the package documentation. Each example is preceded by a comment which gives
# the name of a GAPDoc XML file and a line range from which the example were
# taken. Note that the XML file in turn may have been generated by AutoDoc
# from some other input.
#
gap> START_TEST("smallsemi01.tst");

# doc/examples.xml:285-288
gap> iter := IteratorOfSmallSemigroups(8, IsCommutativeSemigroup, false);
<iterator of semigroups of size 8>

# doc/examples.xml:297-302
gap> enum1 := EnumeratorOfSmallSemigroupsByIds([8], [[1 .. 2 ^ 24 - 1]]);
<enumerator of semigroups of size 8>
gap> enum2 := EnumeratorOfSmallSemigroups(enum1, IsCommutativeSemigroup, false);
<enumerator of semigroups of size 8>

#
gap> STOP_TEST("smallsemi01.tst", 1);
