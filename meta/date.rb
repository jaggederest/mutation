# frozen_string_literal: true

Mutation::Meta::Example.add :send do
  source 'Date.parse(nil)'

  singleton_mutations
  mutation 'Date.parse'
  mutation 'self.parse(nil)'
  mutation 'Date'
  mutation 'Date.jd(nil)'
  mutation 'Date.civil(nil)'
  mutation 'Date.strptime(nil)'
  mutation 'Date.iso8601(nil)'
  mutation 'Date.rfc3339(nil)'
  mutation 'Date.xmlschema(nil)'
  mutation 'Date.rfc2822(nil)'
  mutation 'Date.rfc822(nil)'
  mutation 'Date.httpdate(nil)'
  mutation 'Date.jisx0301(nil)'
end

Mutation::Meta::Example.add :send do
  source '::Date.parse(nil)'

  singleton_mutations
  mutation '::Date.parse'
  mutation 'Date.parse(nil)'
  mutation 'self.parse(nil)'
  mutation '::Date'
  mutation '::Date.jd(nil)'
  mutation '::Date.civil(nil)'
  mutation '::Date.strptime(nil)'
  mutation '::Date.iso8601(nil)'
  mutation '::Date.rfc3339(nil)'
  mutation '::Date.xmlschema(nil)'
  mutation '::Date.rfc2822(nil)'
  mutation '::Date.rfc822(nil)'
  mutation '::Date.httpdate(nil)'
  mutation '::Date.jisx0301(nil)'
end

Mutation::Meta::Example.add :send do
  source 'Date.iso8601(nil)'

  singleton_mutations
  mutation 'Date.iso8601'
  mutation 'self.iso8601(nil)'
  mutation 'Date'
end

Mutation::Meta::Example.add :send do
  source 'Foo::Date.parse(nil)'

  singleton_mutations
  mutation 'Foo::Date.parse'
  mutation 'Foo::Date'
  mutation 'Date.parse(nil)'
  mutation 'self.parse(nil)'
end
