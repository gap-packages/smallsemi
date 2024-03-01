#############################################################################
##
##  greensstar.gi                  Smallsemi - a GAP library of semigroups
##  Copyright (C) 2008-2024            Andreas Distler & James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# This file contains the implementations for starred Green's relations of
# semigroups.

# Returns the appropriate equivalence relation which is stored as an attribute.
# The relation knows nothing about itself except its source, range, and what
# type of congruence it is.
InstallMethod(RStarRelation, "for a small semigroup", [IsSmallSemigroup],
function(X)
  local fam, rel;

  fam := GeneralMappingsFamily(ElementsFamily(FamilyObj(X)),
                               ElementsFamily(FamilyObj(X)));

  # Create the default type for the elements.
  rel := Objectify(NewType(fam, IsEquivalenceRelation
                                and IsEquivalenceRelationDefaultRep
                                and IsRStarRelation), rec());
  SetSource(rel, X);
  SetRange(rel, X);
  # AD The following causes weird viewing of the relation on the command line
  SetIsLeftSemigroupCongruence(rel, true);
  if HasIsFinite(X) and IsFinite(X) then
    SetIsFiniteSemigroupStarRelation(rel, true);
  fi;

  # AD rel is objectified using IsRStarRelation, so other Green's relations
  # should not be set to the same object; classes might be set at the point
  # where they are actually computed, i.e. RStarClasses

  return rel;
end);

InstallMethod(LStarRelation, "for a small semigroup", [IsSmallSemigroup],
function(X)
  local fam, rel;

  fam := GeneralMappingsFamily(ElementsFamily(FamilyObj(X)),
                               ElementsFamily(FamilyObj(X)));

  # Create the default type for the elements.
  rel := Objectify(NewType(fam, IsEquivalenceRelation
                                and IsEquivalenceRelationDefaultRep
                                and IsLStarRelation), rec());

  SetSource(rel, X);
  SetRange(rel, X);
  # AD The following causes weird viewing of the relation on the command line
  SetIsRightSemigroupCongruence(rel, true);
  if HasIsFinite(X) and IsFinite(X) then
    SetIsFiniteSemigroupStarRelation(rel, true);
  fi;

  return rel;
end);

InstallMethod(JStarRelation, "for a small semigroup", [IsSmallSemigroup],
function(X)
  local fam, rel;

  fam := GeneralMappingsFamily(ElementsFamily(FamilyObj(X)),
                               ElementsFamily(FamilyObj(X)));

  # Create the default type for the elements.
  rel := Objectify(NewType(fam, IsEquivalenceRelation
                                and IsEquivalenceRelationDefaultRep
                                and IsJStarRelation), rec());

  SetSource(rel, X);
  SetRange(rel, X);
  if HasIsFinite(X) and IsFinite(X) then
    SetIsFiniteSemigroupStarRelation(rel, true);
  fi;

  return rel;
end);

InstallMethod(DStarRelation, "for a small semigroup", [IsSmallSemigroup],
function(X)
    local fam, rel;

    fam := GeneralMappingsFamily(ElementsFamily(FamilyObj(X)),
                                 ElementsFamily(FamilyObj(X)));

    # Create the default type for the elements.
    rel := Objectify(NewType(fam, IsEquivalenceRelation
                                  and IsEquivalenceRelationDefaultRep
                                  and IsDStarRelation), rec());

    SetSource(rel, X);
    SetRange(rel, X);

    if HasIsFinite(X) and IsFinite(X) then
      SetIsFiniteSemigroupStarRelation(rel, true);
    fi;

    return rel;
end);

InstallMethod(HStarRelation, "for a small semigroup", [IsSmallSemigroup],
function(X)
  local fam, rel;

  fam := GeneralMappingsFamily(ElementsFamily(FamilyObj(X)),
                               ElementsFamily(FamilyObj(X)));

  # Create the default type for the elements.
  rel := Objectify(NewType(fam, IsEquivalenceRelation
                                and IsEquivalenceRelationDefaultRep
                                and IsHStarRelation), rec());

  SetSource(rel, X);
  SetRange(rel, X);

  if HasIsFinite(X) and IsFinite(X) then
    SetIsFiniteSemigroupStarRelation(rel, true);
  fi;

  return rel;
end);

### AD The following methods should probably be installed for ViewString

BindGlobal("SMALLSEMI_ViewStarRelation",
function(obj, type)
  Print("<", type, "*-relation on ");
  ViewObj(Source(obj));
  Print(">");
end);

# AD This is overwritten by the method for LeftSemigroupCongruence
InstallMethod(ViewObj, "for Green's R*-relation", [IsRStarRelation],
16,  # to beat IsLeftSemigroupCongruence
obj -> SMALLSEMI_ViewStarRelation(obj, "R"));

# AD This is overwritten by the method for RightSemigroupCongruence
InstallMethod(ViewObj, "for Green's L*-relation", [IsLStarRelation],
16,  # to beat IsRightSemigroupCongruence
obj -> SMALLSEMI_ViewStarRelation(obj, "L"));

InstallMethod(ViewObj, "for Green's J*-relation", [IsJStarRelation],
obj -> SMALLSEMI_ViewStarRelation(obj, "J"));

InstallMethod(ViewObj, "for Green's D*-relation", [IsDStarRelation],
obj -> SMALLSEMI_ViewStarRelation(obj, "D"));

InstallMethod(ViewObj, "for Green's H*-relation", [IsHStarRelation],
obj -> SMALLSEMI_ViewStarRelation(obj, "H"));

InstallMethod(\=, "for starred Green's relations", IsIdenticalObj,
[IsStarRelation and IsEquivalenceRelation,
 IsStarRelation and IsEquivalenceRelation],
function(rel1, rel2)
  if Source(rel1) <> Source(rel2) then
    return false;
  fi;
  # make sure the internal representation is known
  EquivalenceClasses(rel1);
  EquivalenceClasses(rel2);
  return InternalRepStarRelation(rel1) = InternalRepStarRelation(rel2);
end);

# The following operations are constructors for starred Green's class with
# a given element as a representative. The call is for semigroups
# and an element in the semigroup. This function doesn't check that
# the element is actually a member of the semigroup.

InstallMethod(RStarClass, "for a small semigroup ", IsCollsElms,
[IsSmallSemigroup, IsSmallSemigroupElt],
{s, e} -> EquivalenceClassOfElement(RStarRelation(s), e));

InstallMethod(LStarClass, "for a small semigroup", IsCollsElms,
[IsSmallSemigroup, IsSmallSemigroupElt],
{s, e} -> EquivalenceClassOfElement(LStarRelation(s), e));

InstallMethod(HStarClass, "for a small semigroup", IsCollsElms,
[IsSmallSemigroup, IsSmallSemigroupElt],
{s, e} -> EquivalenceClassOfElement(HStarRelation(s), e));

InstallMethod(DStarClass, "for a small semigroup", IsCollsElms,
[IsSmallSemigroup, IsSmallSemigroupElt],
{s, e} -> EquivalenceClassOfElement(DStarRelation(s), e));

InstallMethod(JStarClass, "for a small semigroup", IsCollsElms,
[IsSmallSemigroup, IsSmallSemigroupElt],
{s, e} -> EquivalenceClassOfElement(JStarRelation(s), e));

# Methods to get any starred Green's class in its canonical form

InstallMethod(CanonicalStarClass, "for a H*-class", [IsHStarClass],
cl -> First(HStarClasses(ParentAttr(cl)), y -> Representative(cl) in y));

InstallMethod(CanonicalStarClass, "for a R * - class", [IsRStarClass],
cl -> First(RStarClasses(ParentAttr(cl)), y -> Representative(cl) in y));

InstallMethod(CanonicalStarClass, "for a L*-class", [IsLStarClass],
cl -> First(LStarClasses(ParentAttr(cl)), y -> Representative(cl) in y));

InstallMethod(CanonicalStarClass, "for a D*-class", [IsDStarClass],
cl -> First(DStarClasses(ParentAttr(cl)), y -> Representative(cl) in y));

InstallMethod(CanonicalStarClass, "for a J*-class", [IsJStarClass],
cl -> First(JStarClasses(ParentAttr(cl)), y -> Representative(cl) in y));

# method to find the images under a starred Green's relation of an
# element of a semigroup.

InstallMethod(ImagesElm, "for a starred Green's relation",
[IsStarRelation, IsObject],
function(rel, elm)
  local exp, semi;

  semi := Source(rel);

  if IsRStarRelation(rel) then
    exp := RStarClass(semi, elm);
  elif IsLStarRelation(rel) then
    exp := LStarClass(semi, elm);
  elif IsHStarRelation(rel) then
    exp := HStarClass(semi, elm);
  elif IsDStarRelation(rel) then
    exp := DStarClass(semi, elm);
  elif IsJStarRelation(rel) then
    exp := JStarClass(semi, elm);
  fi;

  return AsSSortedList(exp);
end);

# Returns ImagesElm for one element in each class of <grelation>

InstallMethod(Successors, "for a starred Green's relation",
[IsStarRelation],
rel -> List(EquivalenceClasses(rel), AsSSortedList));

# Returns the elements of the *-class <gclass>

InstallMethod(AsSSortedList, "for a starred Green's class", [IsStarClass],
x -> AsSSortedList(CanonicalStarClass(x)));

# Equality of *-classes
InstallMethod(\=, "for starred Green's classes",
[IsStarClass, IsStarClass],
function(class1, class2)
  if ParentAttr(class1) <> ParentAttr(class2) then
    return false;
  fi;
  return Representative(class1) in class2;
end);

# Size of a starred Green's class
InstallMethod(Size, "for a starred Green's class", [IsStarClass],
class -> Size(Elements(class)));

# Membership test for a starred Green's class
InstallMethod(\in, "membership test of starred Green's class",
[IsObject, IsStarClass],
function(elm, class)
  if elm = Representative(class) then
     return true;
  fi;
  return elm in Elements(class);
end);

InstallMethod(EquivalenceRelationPartition, "for a starred Green's equivalence",
[IsEquivalenceRelation and IsStarRelation],
rel -> Filtered(Successors(rel), x -> not Length(x) <> 1));

# New methods required so that what is returned by this function
# is the appropriate type of starred Green's class.

InstallOtherMethod(EquivalenceClassOfElementNC,
"for a starred Green's relation",
[IsEquivalenceRelation and IsStarRelation, IsObject],
function(rel, rep)
  local new;

  new := Objectify(NewType(CollectionsFamily(FamilyObj(rep)),
                   IsEquivalenceClass and IsEquivalenceClassDefaultRep),
                   rec());

  SetEquivalenceClassRelation(new, rel);
  SetRepresentative(new, rep);
  SetParent(new, UnderlyingDomainOfBinaryRelation(rel));
  SetIsStarClass(new, true);

  if IsRStarRelation(rel) then
      SetIsRStarClass(new, true);
  elif IsLStarRelation(rel) then
      SetIsLStarClass(new, true);
  elif IsHStarRelation(rel) then
      SetIsHStarClass(new, true);
  elif IsDStarRelation(rel) then
      SetIsDStarClass(new, true);
  elif IsJStarRelation(rel) then
      SetIsJStarClass(new, true);
  fi;

  return new;
end);

InstallMethod(EquivalenceClasses, "for a starred Green's R - relation",
[IsEquivalenceRelation and IsRStarRelation], x -> RStarClasses(Source(x)));

InstallMethod(EquivalenceClasses, "for a starred Green's L-relation",
[IsEquivalenceRelation and IsLStarRelation], x -> LStarClasses(Source(x)));

InstallMethod(EquivalenceClasses, "for a starred Green's H - relation",
[IsEquivalenceRelation and IsHStarRelation], x -> HStarClasses(Source(x)));

InstallMethod(EquivalenceClasses, "for a starred Green's D - relation",
[IsEquivalenceRelation and IsDStarRelation], x -> DStarClasses(Source(x)));

InstallMethod(EquivalenceClasses, "for a starred Green's J-relation",
[IsEquivalenceRelation and IsJStarRelation], x -> JStarClasses(Source(x)));

# Return the XStarClass containing the smaller class

InstallOtherMethod(RStarClass, "for a starred Green's H-class",
[IsHStarClass], cl -> RStarClass(ParentAttr(cl), Representative(cl)));

InstallOtherMethod(LStarClass, "for a starred Green's H-class",
[IsHStarClass], cl -> LStarClass(ParentAttr(cl), Representative(cl)));

InstallOtherMethod(DStarClass, "for a starred Green's H-class",
[IsHStarClass], cl -> DStarClass(ParentAttr(cl), Representative(cl)));

InstallOtherMethod(JStarClass, "for a starred Green's H-class",
[IsHStarClass], cl -> JStarClass(ParentAttr(cl), Representative(cl)));

InstallOtherMethod(DStarClass, "for a starred Green's R-class",
[IsRStarClass], cl -> DStarClass(ParentAttr(cl), Representative(cl)));

InstallOtherMethod(JStarClass, "for a starred Green's R-class",
[IsRStarClass], cl -> JStarClass(ParentAttr(cl), Representative(cl)));

InstallOtherMethod(DStarClass, "for a starred Green's L-class",
[IsLStarClass], cl -> DStarClass(ParentAttr(cl), Representative(cl)));

InstallOtherMethod(JStarClass, "for a starred Green's L-class",
[IsLStarClass], cl -> JStarClass(ParentAttr(cl), Representative(cl)));

InstallOtherMethod(JStarClass, "for a starred Green's D-class",
[IsDStarClass], cl -> JStarClass(ParentAttr(cl), Representative(cl)));

# Find all the classes of a particular type

InstallGlobalFunction(LStarPartitionByMT, function(table)
  local mt,         # mutable copy of multiplication table
        n,          # size of <mt>
        profiles,   # types of rows, sorted
        partition,  # partition of indices into R*-classes
        k,          # element counter
        pro,        # profile of current elements row
        pos;        # position of current profile

  # get a mutable copy of the multiplication table
  mt := MutableCopyMat(table);
  n := Length(mt);
  mt{[1 .. n]}[n + 1] := [1 .. n];

  # initialise sorted list of profiles ...
  profiles := EmptyPlist(n);
  # ... and partition into R*-classes
  partition := EmptyPlist(n);

  # loop over elements
  for k in [1 .. n] do
    pro := KernelOfTransformation(TransformationNC(mt[k]));
    pos := PositionSorted(profiles, pro);

    # either ...
    if IsBound(profiles[pos]) and profiles[pos] = pro then
        # add element to part with same profile ...
        Add(partition[pos], k);
    else
        # ... or start a new part
        Add(profiles, pro, pos);
        Add(partition, [k], pos);
    fi;
  od;

  return AsSSortedList(partition);
end);

InstallMethod(RStarClasses, "for a small semigroup", [IsSmallSemigroup],
function(semi)
  local partition,  # partition of indices into R*-classes
        classes,    # the actual classes
        part,       # one part of <partition>, used as loop counter
        rc;         # one R*-class

  # get partition of index set into R*-classes ...
  partition := LStarPartitionByMT(TransposedMat(MultiplicationTable(semi)));

  # ... and use as internal representation
  SetInternalRepStarRelation(RStarRelation(semi), partition);

  # create actual classes as GAP objects
  classes := EmptyPlist(Length(partition));

  for part in partition do
    rc := RStarClass(semi, Elements(semi)[part[1]]);
    Add(classes, rc);
    SetAsSSortedList(rc, Elements(semi){part});
    SetSize(rc, Size(part));
    SetCanonicalStarClass(rc, rc);
  od;

  return classes;
end);

InstallOtherMethod(RStarClasses, "for a starred Green's D-class",
[IsDStarClass], cl -> Filtered(RStarClasses(ParentAttr(cl)),
                               c -> Representative(c) in cl));

InstallOtherMethod(RStarClasses, "for a starred Green's J-class",
[IsJStarClass], cl -> Filtered(RStarClasses(ParentAttr(cl)),
                               c -> Representative(c) in cl));

InstallMethod(LStarClasses, "for a small semigroup", [IsSmallSemigroup],
function(semi)
  local partition,  # partition of indices into L*-classes
        classes,    # the actual classes
        part,       # one part of <partition>, used as loop counter
        lc;         # one L*-class

  # get partition of index set into L*-classes ...
  partition := LStarPartitionByMT(MultiplicationTable(semi));

  # ... and use as internal representation
  SetInternalRepStarRelation(LStarRelation(semi), partition);

  # create actual classes as GAP objects
  classes := EmptyPlist(Length(partition));

  for part in partition do
    lc := LStarClass(semi, Elements(semi)[part[1]]);
    Add(classes, lc);
    SetAsSSortedList(lc, Elements(semi){part});
    SetSize(lc, Size(part));
    SetCanonicalStarClass(lc, lc);
  od;

  return classes;
end);

InstallOtherMethod(LStarClasses, "for a starred Green's D-class",
[IsDStarClass], cl -> Filtered(LStarClasses(ParentAttr(cl)),
                               c -> Representative(c) in cl));

InstallOtherMethod(LStarClasses, "for a starred Green's J-class",
[IsJStarClass], cl -> Filtered(LStarClasses(ParentAttr(cl)),
                               c -> Representative(c) in cl));

# AD would it be better to use JoinEquivalenceRelations?
InstallMethod(DStarClasses, "for a small semigroup", [IsSmallSemigroup],
function(semi)
  local mt,         # multiplication table of <semi>
        left,       # partition of indices into L*-classes
        right,      # partition of indices into R*-classes
        lookupL,    # positions of parts in <left> containing each index
        lookupR,    # positions of parts in <right> containing each index
        partition,  # partition of indices into D*-classes
        classes,    # the actual classes
        part,       # one part of <partition>, used as loop counter
        dc;         # one D*-class

  mt := MultiplicationTable(semi);

  # get R- and L-classes
  LStarClasses(semi);
  RStarClasses(semi);
  left := InternalRepStarRelation(LStarRelation(semi));
  right := InternalRepStarRelation(RStarRelation(semi));

  lookupL := List([1 .. Size(mt)], k -> First(left, part -> k in part));
  lookupR := List([1 .. Size(mt)], k -> First(right, part -> k in part));

  while left <> right do
    left := Unique(List(right, part -> Union(List(part, k -> lookupL[k]))));
    right := Unique(List(left, part -> Union(List(part, k -> lookupR[k]))));
  od;

  partition := AsSSortedList(left);

  SetInternalRepStarRelation(DStarRelation(semi), partition);
  classes := EmptyPlist(Length(partition));

  for part in partition do
    dc := DStarClass(semi, Elements(semi)[part[1]]);
    Add(classes, dc);
    SetAsSSortedList(dc, Elements(semi){part});
    SetSize(dc, Size(part));
    SetCanonicalStarClass(dc, dc);
  od;

  return classes;
end);

InstallOtherMethod(DStarClasses, "for a starred Green's J-class",
[IsJStarClass], cl -> Filtered(DStarClasses(ParentAttr(cl)),
                               c -> Representative(c) in cl));

InstallMethod(JStarClasses, "for a small semigroup", [IsSmallSemigroup],
function(semi)
  local mt,         # multiplication table of <semi>
        n,          # size of <mt>
        jideals,    # Green's J*-ideals of all elements
        partition,  # partition of indices into J*-classes
        set,        # a subset of the indices to become a part of <partition>
        classes,    # list of Green's J*-classes
        rest,       # elements not yet sorted into classes
        elm,        # element for building next class
        part,       # one part of <partition>, used as loop counter
        jc,         # one J*-class
        # AD the ideal computation should certainly become a user function
        # AD but the necessary technicalities are unclear to me
        greensStarJIdealRaw;

  greensStarJIdealRaw := function(elm)
    local ideal,     # the Green's J*-ideal of <elm>
          new,       # auxiliary variable for construction of <ideal>
          trans,     # transposed of <mt>
          dclasses,  # internal representation of Green's D*-classes
          greensJIdeal;

    # AD this step is rather inefficient in its current form
    # AD it should be replaced by a call to an attribute
    greensJIdeal := function(a)
      local regid;  # the regular Greens J-ideal of <a>
      # {a} \cup aS
      regid := Union(mt[a], [a]);
      # {a} \cup aS \cup aS \cup SaS
      return Union(regid, Union(List(regid, x -> trans[x])));
    end;

    trans := TransposedMat(mt);
    DStarClasses(semi);
    dclasses := InternalRepStarRelation(DStarRelation(semi));
    dclasses := List([1 .. n], x -> First(dclasses, cl -> x in cl));

    new := [elm];

    repeat
      ideal := new;
      new := Union(List(ideal, greensJIdeal));
      new := Union(List(new, x -> dclasses[x]));
    until new = ideal;

    return ideal;
  end;

  mt := MultiplicationTable(semi);
  n := Size(mt);

  jideals := List([1 .. n], greensStarJIdealRaw);

  partition := EmptyPlist(Size(mt));
  rest := [1 .. Size(mt)];

  repeat
    # take one of the remaining elements
    elm := rest[1];

    # get remaining elements in the same class
    set := Filtered(Intersection(rest, jideals[elm]),
                    x -> elm in jideals[x]);

    # remember new class and prepare for next step
    Add(partition, set);
    rest := Difference(rest, set);
  until IsEmpty(rest);

  MakeImmutable(partition);
  SetIsSSortedList(partition, true);

  SetInternalRepStarRelation(JStarRelation(semi), partition);
  classes := EmptyPlist(Length(partition));

  for part in partition do
      jc := JStarClass(semi, Elements(semi)[part[1]]);
      Add(classes, jc);
      SetAsSSortedList(jc, Elements(semi){part});
      SetSize(jc, Size(part));
      SetCanonicalStarClass(jc, jc);
  od;

  SetJStarClasses(semi, classes);

  return classes;
end);

InstallMethod(HStarClasses, "for a small semigroup", [IsSmallSemigroup],
function(semi)
    local left,       # partition of indices into L*-classes
          lpart,      # one part of <left>
          right,      # partition of indices into R*-classes
          rpart,      # one part of <right>
          partition,  # partition of indices into D*-classes
          classes,    # the actual classes
          part,       # one part of <partition>, used as loop counter
          hc;         # one H*-class

    # get R- and L-classes
    LStarClasses(semi);
    RStarClasses(semi);

    left := InternalRepStarRelation(LStarRelation(semi));
    right := InternalRepStarRelation(RStarRelation(semi));

    partition := [];

    for lpart in left do
      for rpart in right do
        Add(partition, Intersection(lpart, rpart));
      od;
    od;

    partition := AsSSortedList(Filtered(partition, p -> not IsEmpty(p)));

    SetInternalRepStarRelation(HStarRelation(semi), partition);
    classes := EmptyPlist(Length(partition));

    for part in partition do
      hc := HStarClass(semi, Elements(semi)[part[1]]);
      Add(classes, hc);
      SetAsSSortedList(hc, Elements(semi){part});
      SetSize(hc, Size(part));
      SetCanonicalStarClass(hc, hc);
    od;
    SetHStarClasses(semi, classes);
    return classes;
end);

InstallOtherMethod(HStarClasses, "for a starred Green's class",
[IsStarClass], cl -> Filtered(HStarClasses(ParentAttr(cl)),
                              c -> Representative(c) in cl));
