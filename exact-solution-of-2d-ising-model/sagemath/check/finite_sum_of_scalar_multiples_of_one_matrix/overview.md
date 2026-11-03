# SageMath Check: finite_sum_of_scalar_multiples_of_one_matrix

## 対象

**対象ラベル**: `finite_sum_of_scalar_multiples_of_one_matrix`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_finite_sum_of_scalar_multiples_of_one_matrix`（一つの行列のスカラー倍の有限和は係数の有限和によるスカラー倍に等しい）
- 範囲: 証明の成分の 4 等号の鎖と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `(Σ_j (c_jA))_{ik} = Σ_j (c_jA)_{ik} = Σ_j c_jA_{ik} = (Σ_j c_j)A_{ik} = ((Σ_j c_j)A)_{ik}` と主張 | `check_entry_chain.sage` | c_j と A の成分を `QQ` 上の多項式環の不定元に置き、(m, n) ∈ {1,2,3}^2、r = 1..5 の全ての成分で各行を本文の成分の式で組んで隣と比べる。主張を Sage の行列演算とも比べる。対照: 係数の和の代わりに最後の係数だけを掛けたものとは一致しない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: すべて `QQ` 上の多項式環。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。浮動小数点は使わない。
- **作り方で自明な比較**: 第 1 等号（`finite_sum_of_matrices_entrywise`）と第 4 等号（スカラー倍の定義）は、両辺を本文の成分の式から作るので比較は定義を当てはめた値が通ることを見るだけである。中身を持つのは第 3 等号（ℂ の有限和の分配則）である。
- 範囲外: r ≥ 6、m または n ≥ 4。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_scalar_multiples_of_one_matrix
```

実行ログは `logs/` に保存する。
