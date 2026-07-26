# SageMath Check: 141_ad_binomial

## 対象

**対象ラベル**: `ad_binomial` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/005_exp_conjugation_proof.mjs`

- 範囲: ad_X^m(Y) = Σ_k C(m,k) X^k Y (−X)^{m−k}（m = 0..8）

左辺は交換子の再帰、右辺は二項和で、完全に独立な 2 経路。K = C と K = R の両方で確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_binomial.sage` | m=0..8 の恒等式（複素・実の両方） | 192 | 3.523e-13 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

X は Frobenius ノルムで正規化して桁溢れを避けている。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 141
```

実行ログは `sagemath/check/141_ad_binomial/logs/` に保存してある（この表の数値はそのログから取った）。
