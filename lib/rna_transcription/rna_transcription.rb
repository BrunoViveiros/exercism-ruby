class Complement
  DNA_TO_RNA = { 'G' => 'C',
                 'C' => 'G',
                 'T' => 'A',
                 'A' => 'U' }.freeze

  def self.of_dna(rna_sequence)
    rna_sequence.chars.map { |nucleotides| DNA_TO_RNA[nucleotides] }.join
  end
end
