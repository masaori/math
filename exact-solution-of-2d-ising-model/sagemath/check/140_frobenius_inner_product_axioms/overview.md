# SageMath Check: 140_frobenius_inner_product_axioms

## 対象

**対象ラベル**: `frobenius_inner_product_axioms` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/005_exp_conjugation_proof.ts`

- 範囲: (0) 成分表示、(1) 共役対称性、(2) 第2変数線型・第1変数共役線型、(3) 正定値性、Cauchy–Schwarz、三角不等式

⟨A,B⟩ = tr(A*B) をトレースで計算した側と、成分の和で計算した側の 2 経路。Cauchy–Schwarz の等号（B = cA）も踏む。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_axioms.sage` | (0)〜(3)、Cauchy–Schwarz、三角不等式、等号条件 | 728 | 1.008e-15 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

<def_frobenius_inner_product> の内容もこの check に含まれる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 140
```

実行ログは `sagemath/check/140_frobenius_inner_product_axioms/logs/` に保存してある（この表の数値はそのログから取った）。
