# 虚数単位は正錐を持つ部分体に属さない

**対象ラベル**: `claim_imaginary_unit_outside_ordered_subfield`

**実行**: `sage check.sage`

**結果**: 2026-11-20、PASS。有理数体の正錐を標本に、零・単位元・負の単位元と虚数単位の平方を厳密演算で照合した。一般の部分体についての証明は本文と Lean 二版が担う。
