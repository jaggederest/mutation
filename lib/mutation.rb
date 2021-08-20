# frozen_string_literal: true

require 'abstract_type'
require 'adamantium'
require 'anima'
require 'concord'
require 'diff/lcs'
require 'diff/lcs/hunk'
require 'digest/sha1'
require 'etc'
require 'equalizer'
require 'ice_nine'
require 'morpher'
require 'open3'
require 'optparse'
require 'parser'
require 'parser/current'
require 'pathname'
require 'regexp_parser'
require 'set'
require 'stringio'
require 'unparser'

# This setting is done to make errors within the parallel
# reporter / execution visible in the main thread.
Thread.abort_on_exception = true

# Library namespace
#
# @api private
module Mutation
  EMPTY_STRING   = ''
  EMPTY_ARRAY    = [].freeze
  EMPTY_HASH     = {}.freeze
  SCOPE_OPERATOR = '::'

  # Test if CI is detected via environment
  #
  # @return [Boolean]
  def self.ci?
    ENV.key?('CI')
  end
end # Mutation

require 'mutation/version'
require 'mutation/env'
require 'mutation/env/bootstrap'
require 'mutation/util'
require 'mutation/registry'
require 'mutation/ast'
require 'mutation/ast/sexp'
require 'mutation/ast/types'
require 'mutation/ast/nodes'
require 'mutation/ast/named_children'
require 'mutation/ast/node_predicates'
require 'mutation/ast/regexp'
require 'mutation/ast/regexp/transformer'
require 'mutation/ast/regexp/transformer/direct'
require 'mutation/ast/regexp/transformer/named_group'
require 'mutation/ast/regexp/transformer/options_group'
require 'mutation/ast/regexp/transformer/quantifier'
require 'mutation/ast/regexp/transformer/recursive'
require 'mutation/ast/regexp/transformer/root'
require 'mutation/ast/regexp/transformer/text'
require 'mutation/ast/meta'
require 'mutation/ast/meta/send'
require 'mutation/ast/meta/const'
require 'mutation/ast/meta/symbol'
require 'mutation/ast/meta/optarg'
require 'mutation/ast/meta/resbody'
require 'mutation/ast/meta/restarg'
require 'mutation/parser'
require 'mutation/isolation'
require 'mutation/isolation/none'
require 'mutation/isolation/fork'
require 'mutation/parallel'
require 'mutation/parallel/driver'
require 'mutation/parallel/source'
require 'mutation/parallel/worker'
require 'mutation/warning_filter'
require 'mutation/require_highjack'
require 'mutation/mutation'
require 'mutation/mutator'
require 'mutation/mutator/util'
require 'mutation/mutator/util/array'
require 'mutation/mutator/util/symbol'
require 'mutation/mutator/node'
require 'mutation/mutator/node/generic'
require 'mutation/mutator/node/regexp'
require 'mutation/mutator/node/regexp/alternation_meta'
require 'mutation/mutator/node/regexp/capture_group'
require 'mutation/mutator/node/regexp/character_type'
require 'mutation/mutator/node/regexp/end_of_line_anchor'
require 'mutation/mutator/node/regexp/end_of_string_or_before_end_of_line_anchor'
require 'mutation/mutator/node/regexp/greedy_zero_or_more'
require 'mutation/mutator/node/literal'
require 'mutation/mutator/node/literal/boolean'
require 'mutation/mutator/node/literal/range'
require 'mutation/mutator/node/literal/symbol'
require 'mutation/mutator/node/literal/string'
require 'mutation/mutator/node/literal/integer'
require 'mutation/mutator/node/literal/float'
require 'mutation/mutator/node/literal/array'
require 'mutation/mutator/node/literal/hash'
require 'mutation/mutator/node/literal/regex'
require 'mutation/mutator/node/literal/nil'
require 'mutation/mutator/node/argument'
require 'mutation/mutator/node/arguments'
require 'mutation/mutator/node/begin'
require 'mutation/mutator/node/binary'
require 'mutation/mutator/node/const'
require 'mutation/mutator/node/dstr'
require 'mutation/mutator/node/dsym'
require 'mutation/mutator/node/kwbegin'
require 'mutation/mutator/node/named_value/access'
require 'mutation/mutator/node/named_value/constant_assignment'
require 'mutation/mutator/node/named_value/variable_assignment'
require 'mutation/mutator/node/next'
require 'mutation/mutator/node/break'
require 'mutation/mutator/node/noop'
require 'mutation/mutator/node/or_asgn'
require 'mutation/mutator/node/and_asgn'
require 'mutation/mutator/node/defined'
require 'mutation/mutator/node/op_asgn'
require 'mutation/mutator/node/conditional_loop'
require 'mutation/mutator/node/yield'
require 'mutation/mutator/node/super'
require 'mutation/mutator/node/zsuper'
require 'mutation/mutator/node/send'
require 'mutation/mutator/node/send/binary'
require 'mutation/mutator/node/send/conditional'
require 'mutation/mutator/node/send/attribute_assignment'
require 'mutation/mutator/node/when'
require 'mutation/mutator/node/class'
require 'mutation/mutator/node/define'
require 'mutation/mutator/node/mlhs'
require 'mutation/mutator/node/nthref'
require 'mutation/mutator/node/masgn'
require 'mutation/mutator/node/return'
require 'mutation/mutator/node/block'
require 'mutation/mutator/node/if'
require 'mutation/mutator/node/case'
require 'mutation/mutator/node/splat'
require 'mutation/mutator/node/regopt'
require 'mutation/mutator/node/resbody'
require 'mutation/mutator/node/rescue'
require 'mutation/mutator/node/match_current_line'
require 'mutation/mutator/node/index'
require 'mutation/mutator/node/procarg_zero'
require 'mutation/loader'
require 'mutation/context'
require 'mutation/scope'
require 'mutation/subject'
require 'mutation/subject/method'
require 'mutation/subject/method/instance'
require 'mutation/subject/method/singleton'
require 'mutation/matcher'
require 'mutation/matcher/config'
require 'mutation/matcher/compiler'
require 'mutation/matcher/chain'
require 'mutation/matcher/method'
require 'mutation/matcher/method/singleton'
require 'mutation/matcher/method/instance'
require 'mutation/matcher/methods'
require 'mutation/matcher/namespace'
require 'mutation/matcher/scope'
require 'mutation/matcher/filter'
require 'mutation/matcher/null'
require 'mutation/matcher/static'
require 'mutation/expression'
require 'mutation/expression/parser'
require 'mutation/expression/method'
require 'mutation/expression/methods'
require 'mutation/expression/namespace'
require 'mutation/test'
require 'mutation/timer'
require 'mutation/integration'
require 'mutation/selector'
require 'mutation/selector/expression'
require 'mutation/config'
require 'mutation/cli'
require 'mutation/color'
require 'mutation/diff'
require 'mutation/runner'
require 'mutation/runner/sink'
require 'mutation/result'
require 'mutation/reporter'
require 'mutation/reporter/null'
require 'mutation/reporter/sequence'
require 'mutation/reporter/cli'
require 'mutation/reporter/cli/printer'
require 'mutation/reporter/cli/printer/config'
require 'mutation/reporter/cli/printer/env_progress'
require 'mutation/reporter/cli/printer/env_result'
require 'mutation/reporter/cli/printer/isolation_result'
require 'mutation/reporter/cli/printer/mutation_progress_result'
require 'mutation/reporter/cli/printer/mutation_result'
require 'mutation/reporter/cli/printer/status'
require 'mutation/reporter/cli/printer/status_progressive'
require 'mutation/reporter/cli/printer/subject_progress'
require 'mutation/reporter/cli/printer/subject_result'
require 'mutation/reporter/cli/printer/test_result'
require 'mutation/reporter/cli/tput'
require 'mutation/reporter/cli/format'
require 'mutation/repository'
require 'mutation/variable'
require 'mutation/zombifier'

module Mutation
  # Reopen class to initialize constant to avoid dep circle
  class Config
    DEFAULT = new(
      condition_variable: ConditionVariable,
      expression_parser:  Expression::Parser.new([
        Expression::Method,
        Expression::Methods,
        Expression::Namespace::Exact,
        Expression::Namespace::Recursive
      ]),
      fail_fast:          false,
      includes:           EMPTY_ARRAY,
      integration:        Integration::Null,
      isolation:          Mutation::Isolation::Fork.new(
        devnull: ->(&block) { File.open(File::NULL, File::WRONLY, &block) },
        stdout:  $stdout,
        stderr:  $stderr,
        io:      IO,
        marshal: Marshal,
        process: Process
      ),
      jobs:               Etc.nprocessors,
      kernel:             Kernel,
      load_path:          $LOAD_PATH,
      matcher:            Matcher::Config::DEFAULT,
      mutex:              Mutex,
      open3:              Open3,
      pathname:           Pathname,
      reporter:           Reporter::CLI.build($stdout),
      requires:           EMPTY_ARRAY,
      thread:             Thread,
      zombie:             false
    )
  end # Config
end # Mutation
