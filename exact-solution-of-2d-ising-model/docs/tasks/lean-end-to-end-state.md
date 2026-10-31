# Lean の通しの証明と章立てへの組み直しの状態

手順は [lean-end-to-end-runbook.md](lean-end-to-end-runbook.md)。

## 現在地

- 2026-10-31: runbook の「作業の順序」の 1 を終えた。`IsingParam` から独立な欄 `K2star` を外して
  `IsingParam.K2star := Kstar K2`（人手 `def_second_dual_coupling_constant`）とし、人手
  `duality_c2_star_eq_s2_star_c2` を `Part008/ClaimDualityC2StarEqS2StarC2.lean` で具体版として形式化した。
  双対関係は定理 `IsingParam.c2_mul_s2star_eq_c2star` になり、`EvenSectorClosureInput` から `hdual` を外した。
  `lake build`（3027 ジョブ）と `check-no-sorry.sh` は通り、`check-end-to-end.sh` は「通しの定理が無い」で落ちる。
- 最終定理 `Ising2D.onsager_exact_solution_unconditional` に残る仮定:
  - `Z` が具体的な分配関数でなく、挟み撃ちを満たす任意の関数（`hZ1`, `hZ2`）
  - `W` と `V^{(+)}` の橋渡し `bridge`
  - `tr(εV^{(+)}) > 0`（`htr`）
  - `W` の成分の正値性 `hWpos` と `ε` との可換性 `hWcomm`（具体的な `W` では形式化済みだが未接続）
- Part020 に人手の定義と別表示の `KStar`（`arsinh(1/sinh 2K)/2`）が残っている。`Kstar_eq_KStar` で
  人手の `Kstar` へ接続したが、二重定義の解消は項目 7 の章ごとの移動のときに行う。

## 項目 2 の割り直し

調べた結果、人手 `partition_function_via_transfer_matrix`（001 章、`Z = tr((V_1V_2)^{N_row})`）が Lean に無い。
`partition_function_sandwich`（`Part011/Claim009_PartitionFunctionSandwich.lean`）はこれを仮定 `hZ` で受け取り、
`N ≥ 1` を要求する。次の順に割る。

1. 人手 `partition_function_via_transfer_matrix` を具体版で形式化する（`partitionFunction N M K1 K2` と
   `Part001` の `V1`, `V2` の積の冪のトレース）。
2. 実行列 `physicalV1halfR`, `physicalV2R`（`PhysicalSymTransferBridge.lean`）について
   `partition_function_sandwich` の前提（`B*B = V_1`、対称、可逆、`V_2` の正定値）を示し、`N ≥ 1` の挟み撃ちを
   具体的な `Z` と `c(M) := rayleighSup physicalSymTransferR` について得る。`N = 0` は `Z = 1` で別に示す。
3. 最終定理の `Z` と `hZ1`, `hZ2` を、上の具体的なものに置き換える（`hcM` の `W` は項目 3 の接続で具体的な `W` にする）。

## 次の一歩

項目 2 の割り直しの 1：人手 `partition_function_via_transfer_matrix` を具体版で形式化する。
