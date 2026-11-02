# SageMath Check: half_integer_checkZ_periodicity

## 対象

**対象ラベル**: `half_integer_checkZ_periodicity`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensector_003_claim_half_integer_checkZ_periodicity`（`Ž_{μ+M_col} = Ž_μ`）
- 範囲: 証明の 2 等号の鎖（定義、`half_integer_phase_periodicity` の全項への適用、定義）と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `Ž_{μ+M} = Σ_j exp(-i(j_R θ̃_{μ+M})_C)Z_{j_Z}`（定義） | `check_chain_lines.sage` | M = 2..5、μ = -M..2M で、def_half_integer_checkZ を μ+M で組んだ行列と、証明に書かれた和を円分体の行列で厳密に比べる（自明な比較。下記） | **PASS** | 成り立つ |
| `= Σ_j exp(-i(j_R θ̃_μ)_C)Z_{j_Z}`（`half_integer_phase_periodicity` の全項への適用） | `check_chain_lines.sage` | 係数が項ごとに等しいことと、二つの和の行列が厳密に等しいことを見る（自明な比較。下記） | **PASS** | 成り立つ |
| `= Ž_μ`（定義） | `check_chain_lines.sage` | 定義を μ で組んだ行列と比べる。対照: Ž_{μ+1} ≠ Ž_μ（行列の比較が係数の違いを捉える） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: Z_j は def_jordan_wigner_Z_matrices の積を、クロネッカー積と行列の積の成分の式で `QQ(i)` 上に組む（`sagemath/_shared/pauli_sites_exact.sage` の `jw`。Sage 組み込みの経路との一致も確かめる）。
  係数 exp(-i(j_R θ̃)_C) は 1 の冪根として円分体 `CyclotomicField(lcm(4, 2M))` で持つ。浮動小数点は使わない。
- **作り方で自明な比較**: 係数の 1 の冪根は指数を L を法として落とすので、μ と μ+M の係数（指数の差は L の整数倍）の一致と、
  第 2 等号の二つの和の一致は必ず成り立つ。第 1・第 3 等号も定義と同じ式を比べている。したがって鎖の 3 つの比較はすべて自明で、
  この検算の中身は、Jordan–Wigner 行列を本文の定め方で組めることと、対照（Ž_{μ+1} ≠ Ž_μ）が行列の比較の感度を示すことだけである。
  係数の周期性そのものは `half_integer_phase_periodicity` の Arb とボールの検査に依る。
- 係数が本文の exp の値であることは `half_integer_phase_periodicity` の検算（本文の exp のボール）が確かめている。この主張はそれを通じて、全実数上の cos・sin の 2π 周期性（本文では未整備）を前提とする。
- 範囲外: M_col ≥ 6、μ < -M または μ > 2M。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh half_integer_checkZ_periodicity
```

実行ログは `logs/` に保存する。
