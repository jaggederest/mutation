Mutation
======

## What is Mutation?

Mutation is a mutation testing tool for Ruby. Mutation testing is a technique to verify semantic coverage of your code.

This gem is a fork of the latest MIT-licensed version of Mutant, renamed to avoid conflicts with the original gem, which is now being developed under a commercial license.

## Why do I want it?

Mutation adds to your toolbox: Detection of uncovered semantics in your code.
Coverage becomes a meaninful metric!

On each detection of uncovered semantics you have the opportunity to:

* Delete dead code, as you do not want the extra semantics not specified by the tests
* Add (or improve a test) to cover the unwanted semantics.
* Learn something new about the semantics of Ruby and your direct and indirect dependencies.

## How Do I use it?

* Start with reading the [nomenclature](/docs/nomenclature.md) documentation.
* Than select and setup your [integration](/docs/nomenclature.md#interation), also make sure
  you can reproduce the examples in the integration specific documentation.
* Identify your preferred mutation testing strategy. Its recommended to start at the commit level,
  to test only the code you had been touching. See the [incremental](#only-mutating-changed-code)
  mutation testing documentation.

Topics
------

* [Nomenclature](/docs/nomenclature.md)
* [Reading Reports](/docs/reading-reports.md)
* [Known Problems](/docs/known-problems.md)
* [Limitations](/docs/limitations.md)
* [Concurrency](/docs/concurrency.md)
* [Rspec Integration](/docs/mutation-rspec.md)
* [Minitest Integration](/docs/mutation-minitest.md)

Sponsoring
----------

Mutation, as published in the opensource version, would not exist without the help
of [contributors](https://github.com/jaggederest/mutation/graphs/contributors) spending lots
of their private time.

Additionally, the following features where sponsored by organizations:

* The `mutation-minitest` integration was sponsored by [Arkency](https://arkency.com/)
* Mutation's initial concurrency support was sponsored by an undisclosed company that does
  currently not wish to be listed here.

Mutation-Operators
------------------

Mutation supports a wide range of mutation operators. An exhaustive list can be found in the [mutation-meta](https://github.com/jaggederest/mutation/tree/master/meta).
The `mutation-meta` is arranged to the AST-Node-Types of parser. Refer to parsers [AST documentation](https://github.com/whitequark/parser/blob/master/doc/AST_FORMAT.md) in doubt.

There is no easy and universal way to count the number of mutation operators a tool supports.

Neutral (noop) Tests
--------------------

Mutation will also test the original, unmutated, version your code. This ensures that mutation is able to properly setup and run your tests.
If an error occurs while mutation/rspec is running testing the original code, you will receive an error like the following:
```
--- Neutral failure ---
Original code was inserted unmutated. And the test did NOT PASS.
Your tests do not pass initially or you found a bug in mutation / unparser.
...
Test Output:
marshal data too short
```
Currently, troubleshooting these errors requires using a debugger and/or modyifying mutation to print out the error. You will want to rescue and inspect exceptions raised in this method: lib/mutation/integration/rspec.rb:call

Only Mutating Changed Code
--------------------------

Running mutation for the first time on an existing codebase can be a rather disheartening experience due to the large number of alive mutations found! Mutation has a setting that can help. Using the `--since` argument, mutation will only mutate code that has been modified. This allows you to introduce mutation into an existing code base without drowning in errors. Example usage that will mutate all code changed between master and the current branch:

```
bundle exec mutation --include lib --require virtus --since master --use rspec Virtus::Attribute#type
```

Note that this feature requires at least git `2.13.0`.

Credits
-------

* [Markus Schirp (mbj)](https://github.com/mbj) and the open source version of Mutant, which is now sadly commercially licensed. This repository is based on the latest MIT-licensed code and renamed to avoid conflicts.
* A gist, now removed, from [dkubb](https://github.com/dkubb) showing ideas.
* Older abandoned [mutation](https://github.com/txus/mutation). For motivating me doing this one.
* [heckle](https://github.com/seattlerb/heckle). For getting me into mutation testing.

Contributing
-------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with Rakefile or version
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

License
-------

See LICENSE file.
