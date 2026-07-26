# SageMath Check: 170_kronecker_product_rule

## 対象

**対象ラベル**: `kronecker_product_rule` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`

- 範囲: (1) (A₁⊠…⊠A_M)(B₁⊠…⊠B_M) = (A₁B₁)⊠…⊠(A_MB_M)、(2) I⊠…⊠I = I_{2^M}、(3) ベクトルへの作用

加えて、**成分の定義式**（ν(I) = 1 + Σ(i_k−1)2^{M−k} による添字づけのもとで成分が因子の積になること）を全 (I,J) で直接確認している。これは numpy の kron の順序規約が本文の ν と一致することの裏付けでもある。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_product_rule.sage` | (1)〜(3) と成分の定義式 | 1439 | 5.823e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

本文は最近テンソル積を抽象的な記号から具体的なクロネッカー積へ書き換えており、この check はその新しい定義に対するもの。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 170
```

実行ログは `sagemath/check/170_kronecker_product_rule/logs/` に保存してある（この表の数値はそのログから取った）。
