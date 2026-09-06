# 章 010 の `sector_replacement_of_V1` にあった未形式化依存の解消記録

対象: `structured-latex/content/010_transfer_matrix_bridge.ts` の
`bridge_011_claim_sector_replacement`（ラベル `sector_replacement_of_V1`）

## 解消前に何が問題だったか（人手証明側の誤りではない）

人手本文 `sector_replacement_of_V1` の `V_1 P^{(±)} = V_1^{(±)} P^{(±)}` の証明は、
**004 章の `V1_restriction_to_eigenspaces`**
（`structured-latex/content/004_transfer_matrix.ts` の
`transfer_matrix_006_claim_V1_restriction_to_eigenspaces`、
「`(end(V_1))|_{𝓕^{(±)}} = (end(exp(iK_1(Y_1Z_2+⋯∓Y_MZ_1))))|_{𝓕^{(±)}}`」）
だけを根拠にしている。人手証明としてはこれで閉じている。

解消前は **Lean 側に 004 章のこの命題が無かった**。004 章で形式化済みだったのは
`def_transfer_matrix_symbols` 系の定義（`Ising2D.sigmaX/Y/Z`, `Z`, `Y`, `epsilon`）と
`V_1^{(±)}` の定義（`Ising2D.V1`）までで、固有空間への制限は未形式化だった
（`lean/README.md` の「現在形式化済みの命題」表に該当項目が無いことを確認した）。

## 解消前に Lean 側でどう扱ったか（一次情報）

`lean/Ising2D/Part010/Claim011_SectorReplacement.lean` で、原文の主張を
仮定として明示的に受け取る述語を定義した。

```lean
def RestrictsOnSector (M : ℕ) (K1 ηsign η : ℂ) : Prop :=
  ∀ f : Conf M → ℂ, epsilon M *ᵥ f = η • f →
    V1pauli M K1 *ᵥ f = V1 M K1 ηsign *ᵥ f
```

当時はこの仮定のもとで

* `Ising2D.sector_replacement_of_V1`（人手本文 `sector_replacement_of_V1`）
* `Ising2D.sector_replacement_pow`（人手本文 `sector_replacement_pow`。抽象版 `Ising2D.NecSuf.pow_mul_proj` の系）
* `Ising2D.partition_function_sector_decomposition`（原文 `bridge_012` の最終式）

を証明していた（`sorry` なし。`scripts/check-no-sorry.sh` は exit 0）。

`sector_replacement_pow` 以降は `sector_replacement_of_V1` から**純代数的に**従うので、この仮定は `sector_replacement_of_V1` の 1 点にだけ効いていた。

## 2026-09-06 の進展と残作業

004 章の `V1_restriction_to_eigenspaces` は、`M>=2` と `ηsign=-η` の下で
`V1_restrictsOnSector_of_opposite_sign` として証明した。実際の二つの符号対も
`V1_restrictsOnEvenSector` と `V1_restrictsOnOddSector` で得られる。

`sector_replacement_of_V1`、`sector_replacement_pow`、トレース接続の補助定理、
`partition_function_sector_decomposition` は `M>=2` を直接受け取る形へ同期した。
`ηsign=-η` の制限定理を内部で使うため、下流に `RestrictsOnSector` 仮定は残らない。

なお `Ising2D.partition_function_in_pauli_form`（章 010 の `bridge_007`、
`Z(J,J') = tr((V_1V_2)^{N_row})`）は**この仮定を使っていない**。
分配関数から Pauli 表示までの橋渡しは無条件に閉じている。
