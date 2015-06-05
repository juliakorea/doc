Conclusion
==========

It is probably not possible to define technical computing precisely.
That is just as well, since being “domain specific” is not our goal.
Programming languages want to be general purpose, and evidence suggests
people want them to be as well. Recent analysis of programming language
adoption  found that when a language is popular only within a certain
niche, it is not usually the most popular language in that niche —
broadly popular, general languages are still preferred. We speculate
that wherever this property fails to hold, there is an opportunity to
improve our general purpose languages. As noted in the introduction, at
least some forms of technical computing, however imprecisely defined,
have surely been just such a case. This dissertation takes a small step
towards understanding this niche in a more general framework.

We began by observing that technical computing users have priorities
that have rarely been addressed directly by programming languages.
Arguably, even many of the current technical computing languages only
address these priorities for a subset of cases. In some sense all that
was missing was an appropriate notion of partial information. Partial
information has many uses. It describes sets of values, and therefore
code applicability. It describes what sorts of information a compiler
can determine, contributing to a performance model. It leads to staged
programming: generating code requires knowing something about what needs
to be computed, but not everything, so that generated code can be reused
enough to be worthwhile. Of course, this sounds a lot like a type
system. However programmers in our area of interest, and working in
dynamic languages generally, have resisted this. In our view this can
change as more uses of types are discovered and advocated. Surely there
are many more ways to obtain useful run time behavior based on partial
information.

The rest of this concluding chapter will reflect on what more could be
done.

Performance
-----------

If we are interested in abstraction, then type specialization is the
first priority for getting performance. However in a broader view there
is much more to performance. For example “code selection” appears in a
different guise in the idea of *algorithmic choice* . At any point in a
program, we might have a choice of several algorithms and want to
automatically pick the fastest one. Julia’s emphasis on writing
functions in small pieces and describing applicability seems naturally
suited to this functionality. A possible approach could be to dispatch
on components of an execution plan object.

High-performance code generators such as Spiral  often specialize on
data size. Julia makes it easy to represent array sizes in the type
system, and the usual pattern of dynamic dispatch to specialized code
could be applicable in these cases as well. While Julia includes a
distributed computing library, we have not sufficiently explored shared
memory parallelism. The Cilk model  would be a good match for the level
of performance and abstraction we aim for.

Other future work
-----------------

As with any practical system, we must begin the process of trying to get
back what our design initially trades away. For example, the
specialization-based polymorphism we use does not support separate
compilation. Fortunately that’s never stopped anyone before: C++
templates have the same problem, but separately compiled modules can
still be generated. We plan to do the same, with the same cost of
re-analyzing all relevant code for each module. Another approach is to
use layering instead of separate modules. Starting with the core
language, one next identifies and compiles a useful base library. That
layer is then considered “sealed” and can no longer be extended — it
effectively becomes part of the language. Applications using this
library can be compiled more efficiently. More layers can be added
(slowest-changing first) to support more specific use cases. This is
essentially the “telescoping languages” approach .

An ideal approach to higher-order programming in Julia remains somewhat
elusive. For example the ``map`` function in
section [sec:implementingmap] always returns an array of element type
``Bottom`` when the input array is empty, which is fully defensible but
still confusing and surprising to many programmers. It is possible the
situation could be improved by some syntactic sugar for nominal arrow
types.

Approaches to static type checking are also worth thinking about. Most
importantly, we feel we have the priorities right: first introduce at
least some kind of type information, then gradually add checks and
tooling to improve safety. For example, a useful alternative form of the
language could require types to match when control flow edges meet.
Tools like ``TypeCheck.jl``  can be used to take better advantage of
whatever type information we are able to infer.

Project status
--------------

Not only is Julia free software, but we want to make the most of it by
facilitating reading and modifying its code. Most of Julia is defined in
libraries, lowering the barrier to contributing to more aspects of the
system. There are currently 590 packages listed in our package
management system, and the majority of them are written entirely in
Julia.
