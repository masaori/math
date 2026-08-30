# SageMath Check: 168_end_is_algebra_isomorphism

## 対象

**対象ラベル**: `end_is_algebra_isomorphism` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`

- 範囲: (1) 線型同型、(2) end(AB)=end(A)∘end(B)、(3) end(I)=id

**注意**: このプロジェクトは Mat(2,C)^{⊗M} を具体的なクロネッカー積として実装しているので、(2)(3) は行列表現では恒等的に成り立ち、実質的な検証内容は (1) の行列単位の一次独立性である。分離したクロネッカー積の作用公式は `end_acts_on_kronecker_products` の検証へ移した。

## チェック一覧

| ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---------|---------|-------|------------|-----------|
| `check_algebra_isomorphism.sage` | (1)〜(3)（実質は (1)） | 20 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 168
```

実行ログは `sagemath/check/168_end_is_algebra_isomorphism/logs/` に保存してある（この表の数値はそのログから取った）。
