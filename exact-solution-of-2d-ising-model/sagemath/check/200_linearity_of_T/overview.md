# SageMath Check: 200_linearity_of_T

## 対象

**対象ラベル**: `linearity_of_T` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.ts`

- 範囲: 任意の可逆な有限複素行列による共役写像 T_g の C-線型性

Gaussian 有理数体 `ℚ(i)` 上の一般行列 X, W と、非零対角成分を持つ上三角可逆行列 g に対し、本文の六つの等式変形を一行ずつ厳密等号で確認する。
各行は書かれた括弧どおりに、積・和・スカラー倍を本文の定義（`mat_mult`・`def_matrix_sum`・`def_matrix_scalar_multiple`）の成分の式で組んで比べ、`T_g(h)` は `(gh)g^{-1}` と読む。主張は Sage 組み込みの演算（独立な経路）とも比べ、否定コントロールとして `b` の項を落とした右辺とは一致しないことも確かめる。
最初の行（`T_g` の定義）と最後の行（`T_g` の定義へ戻す）は、`T_g` を同じ組み方で組むので構成上かならず一致し、検出できるのは本文の式の写し間違いだけである。これを補うため、主張は Sage 組み込みの演算とも比べた。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_linearity.sage` | 定義・右の因子の和への分配（`mat_mult_distributes_over_sum_in_right_factor`）・左の因子の和への分配（`mat_mult_distributes_over_sum_in_left_factor`）・右の因子と左の因子のスカラー倍を外へ出す段（`scalar_multiple_factors_out_of_right_factor`・`scalar_multiple_factors_out_of_left_factor`）・定義へ戻す段を一行ずつ厳密検査し、主張を Sage の演算と比べ、否定コントロールを確かめる | 72 | 厳密等号 | **PASS** |

各判定は `ℚ(i)` 上の厳密等号であり、許容誤差は用いない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 200
```

実行ログは `sagemath/check/200_linearity_of_T/logs/` に保存してある（この表の数値はそのログから取った）。
