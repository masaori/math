# SageMath Check: 168_end_is_algebra_isomorphism

## 対象

**対象ラベル**: `end_is_algebra_isomorphism` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.mjs`

- 範囲: (1) 線型同型、(2) end(AB)=end(A)∘end(B)、(3) end(I)=id、(4) テンソル積の作用が成分ごと

**注意**: このプロジェクトは Mat(2,C)^{⊗M} を具体的なクロネッカー積として実装しているので、(2)(3) は行列表現では恒等的に成り立ち、数値検証としての情報量はない。実質的な内容は (4)（(A₁⊗…⊗A_M)(v₁⊗…⊗v_M) = (A₁v₁)⊗…⊗(A_Mv_M)）と (1)（行列単位が 4^M 個の一次独立な元をなす）である。overview として、その区別を明示しておく。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_tensor_action.sage` | (1)〜(4)（実質は (1) と (4)） | 40 | 4.830e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 168
```

実行ログは `sagemath/check/168_end_is_algebra_isomorphism/logs/` に保存してある（この表の数値はそのログから取った）。
