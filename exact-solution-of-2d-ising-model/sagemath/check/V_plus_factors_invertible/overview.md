# SageMath Check: V_plus_factors_invertible

## 対象

**対象ラベル**: `V_plus_factors_invertible`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensectorT_claim_V_plus_factors_invertible`（V^{(+)} の可逆性）
- 範囲: 証明の二つの式 `BV_2 ∈ R^×` と `V^{(+)} = (BV_2)B ∈ R^×`（`B := (V_1^{(+)})^{1/2}`）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 二つの式の全て（厳密） | `check_membership_exact.sage` | `K_1 = 2 log y`、`K_2 = log x` として `B^{±1}`・`V_2`・`V_2^{-1}` を `QQ`・`AA` に作り、(ii) の逆元で両順の積が I、`(BV_2)B = B(V_2B)`、Sage の `inverse` との一致。対照: `B^{-1}V_2^{-1}` は `BV_2` の逆元にならない | **PASS** | `M_col = 2..4`、`x, y ∈ {2, 3}` で厳密等号 |
| `BV_2 ∈ R^×`（`def_invertible_elements_of_R` (ii)、`g_1 → B`、`g_2 → V_2`） | `check_membership_chain.sage` | (ii) の逆元 `V_2^{-1}B^{-1}` を掛けると両順で I と重なり、Sage の逆行列とも重なる。対照: 順を入れ替えた `B^{-1}V_2^{-1}` では I と交わらない成分がある | **PASS** | `M_col = 2..4`、`x ∈ {2, 3}`、`K_1 ∈ {1/4, 1/2}` |
| `V^{(+)} = (BV_2)B`（`def_V_plus`） | 同上 | `(BV_2)B` のボールが括弧を替えた `B(V_2B)` と重なる（`def_V_plus` の括弧の約束） | **PASS** | 同上 |
| `∈ R^×`（(ii)、`g_1 → BV_2`、`g_2 → B`） | 同上 | (ii) の逆元 `B^{-1}(V_2^{-1}B^{-1})` を掛けると両順で I と重なり、Sage の逆行列とも重なる | **PASS** | 同上 |

## 計算の帰属と範囲

- 厳密の検算は `K_1 = 2 log y` として `B^{±1} = exp(±X) = Σ_λ y^{±λ}P_λ`（`iH_1^{(+)}` の固有値の射影）を `QQ` に作る。ℝ への脱出は `K_1`・`K_2` の選び方だけである。
- `check_membership_chain.sage` は補助で、`B`・`B^{-1} = exp(±X)`（`X := (i/2)(K_1)_ℂ H_1^{(+)}`、`K_1 ∈ {1/4, 1/2}`）を本文の部分和に尾の上界を半径として足した 256 ビットのボールで囲む（ℝ への脱出: `exp` の極限）。
- `V_2`・`V_2^{-1}` は `K_2 = log x` として `V_2` を `def_transfer_matrix` の成分で、`V_2^{-1}` を `V2_invertible` の証明の `h = (a^{-1})_C exp(-Y)` で `AA` に厳密に作り、`V_2h = hV_2 = I` を厳密に確かめてからボールへ移す（共通の準備 `sagemath/_shared/transfer_matrix_factor_inverses.sage`）。
- 許容誤差は置かず、ボールが重なるか（等号）と、対照では交わらない成分があるかだけで判定する。
- 範囲外: `M_col ≥ 5`。

## 確かめられない行と理由

- 証明の二つの式は (ii) の当てはめ（推論）であり、計算を含まない。検算は (ii) が与える逆元の値で積が I になることと、Sage が独立に求めた逆行列との一致を確かめる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh V_plus_factors_invertible
```

実行ログは `logs/` に保存する。
