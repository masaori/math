# SageMath Check: exp_hermitian_is_positive_definite

## 対象

**対象ラベル**: `exp_hermitian_is_positive_definite` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_013_claim_exp_hermitian_positive_definite`（エルミート行列の exp は正定値）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `H^* = H` | `check_preparation.sage` | `S` をエルミートな不定元の表に置き、`n = 1,…,4` で確かめた | **PASS** | 全て PASS |
| 準備 `(H+H)_kl = S_kl` の 8 行 | 同上 | 同上の全成分で隣り合う行が等しい。Sage の和とも比べた | **PASS** | 同上 |
| 主張の鎖 `exp(S) = exp(H+H) = exp(H)exp(H) = TT = T^*T = T^*(IT)` と `T'T = I`（形式冪級数） | `check_main_chain_and_positivity.sage` | `S` を `tS`（エルミートな不定元の表）に置き、本文の部分和で各行が `t` の 6 次まで一致することを確かめた（`n = 1, 2`） | **PASS** | 同上 |
| 主張の鎖と `T'T = I`（ℝ への脱出を含む値） | 同上 | 具体のエルミートな `QQ(i)` の行列（`n = 1,…,4`、各 3 個）で、各行の本文のボールが重なること、`T'T` のボールが `I` を含むこと、本文の `exp(S)` が Sage の `exp` と重なることを確かめた | **PASS** | 同上 |
| 主張（`exp(S)` は正定値） | 同上 | 同じ `S` と各 8 本の零でない `x` で、`x^*exp(S)x` のボールの虚部が 0 を含み実部が正であることを、本文の `exp` と Sage の `exp` の両方で確かめた。補助の確認として、`x^*exp(S)x` のボールが `w := Tx` の `Σ conj(w_k)w_k` のボールと重なることも確かめた（書き換えた証明にこの行は無い） | **PASS** | 同上 |

## 計算の帰属と範囲

準備と形式冪級数の段は不定元で厳密に確かめた。exp の値は `ℝ` への脱出なので 256 ビットの区間で囲んだ（尾の上界を半径に足すので囲みは厳密）。

本文の部分和のボールを Sage 組み込みの `ComplexBallField` の `exp` と比べた。

## 確かめられない行と理由

`N → ∞` の極限は有限の計算では確かめられない。正値性の検算は具体の `S` と `x` についてのもので、全ての `x` についての主張は人手証明（`congruence_preserves_positive_definite` を `A = I` に当てはめる段）が担う。`T^*T = T^*(IT)` の行は `identity_matrix_is_left_unit_of_mat_mult` の当てはめで、検算では同語反復に近い。ボールの鎖の 1 行目 `exp(S) = exp(H+H)` は、`H + H = S` が `QQ(i)` で厳密に成り立つので同じボールどうしの比較になり、何も確かめていない。この行は準備の `H + H = S` の 8 行の検算が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh exp_hermitian_is_positive_definite
```

実行ログは `sagemath/check/exp_hermitian_is_positive_definite/logs/` に保存する。
