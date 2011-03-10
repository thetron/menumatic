class Hash
  # Behaves the same as [merge] but instead of replacing values, they are
  # automatically joined using the separator parameter
  def merge_with_join(other_hash, separator = " ")
    self.merge(other_hash){ |key, value_1, value_2| [value_1, value_2].join(separator) }
  end
end
