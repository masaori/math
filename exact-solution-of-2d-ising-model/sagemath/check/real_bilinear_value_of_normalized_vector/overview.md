# SageMath Check: real_bilinear_value_of_normalized_vector

## 対象

**対象ラベル**: `real_bilinear_value_of_normalized_vector` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/011_max_eigenvalue.ts`
- ブロック: `maxeig_claim_real_bilinear_value_of_normalized_vector`（`P ∈ Mat(n,ℝ)`、`v ≠ 0`、`v̂_k := v_k/‖v‖` について `v̂^⊤Pv̂ = (v^⊤Pv)/‖v‖^2`）
- 範囲: 証明の準備の 2 行の鎖（`v̂_k = v_k/‖v‖ = (1/‖v‖)v_k`）と主張の 4 行の鎖。`x^⊤Py` は `def_real_bilinear_value` の `Σ_kΣ_l (x_kP_kl)y_l` で組む。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の 2 行と主張の 4 行の鎖 | `check_proof_lines.sage` | `n = 1, …, 5` で、負の成分を含む決め打ちの `v` と対称でない決め打ちの `P` の 1 組と、零でない有理数の `v` と有理数の `P` の 6 組（種は固定）の計 7 組ずつ（計 35 組）取り、`‖v‖ > 0`・`‖v‖^2 > 0` と、準備の各 `k` の 2 段と主張の 4 段で隣り合う行の値が等しいことを確かめる（350 段）。否定コントロール 1 件（`‖v‖^2` ではなく `‖v‖` で割った誤った右辺は `P = I`、`v = (3, 4)` で左辺と一致しない） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 成分は QQ、根号と商は AA（実代数的数）で計算する。浮動小数点は使わない。
- 範囲外: `n ≥ 6`、選んだ以外の `(P, v)`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_bilinear_value_of_normalized_vector
```

実行ログは `logs/` に保存する（2026-11-07）。
