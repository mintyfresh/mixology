# frozen_string_literal: true

Unitwise.register(
  names:        %w[dash dashes],
  symbol:       'dash',
  primary_code: 'dash',
  property:     'fluid volume',
  scale:        {
    value:     0.92,
    unit_code: 'mL'
  }
)

Unitwise.register(
  names:        %w[splash splashes],
  symbol:       'splash',
  primary_code: 'splash',
  property:     'fluid volume',
  scale:        {
    value:     5.91,
    unit_code: 'mL'
  }
)
