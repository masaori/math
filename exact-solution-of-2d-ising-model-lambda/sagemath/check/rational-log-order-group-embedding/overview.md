# SageMath Check: 対数順序群から有理係数の対数順序群への写像

## 対象

**対象ラベル**: `claim_rational_log_order_group_embedding`

- 実行日: 2026-08-15
- 状態: PASS（131 件）
- 帰属: すべて `ZZ` / `QQ` の厳密計算。浮動小数点は使わない。

## 検査内容

- $\Lambda$ の元 5 個（有限台の整数値辞書）の全 25 組について、素数 $2,3,5,7,11$ の各点で
  証明の 5 行（$\iota$ の定義、$\Lambda$ の加法の定義、分母 1 の有理数の加法、$\iota$ の定義、
  $\Lambda_{\mathbb{Q}}$ の加法の定義）が一致することと、像の一致から元の一致が従うこと（単射性）を検査する。
- 有理数倍について、台が増えないこと、$(r+s)\lambda=r\lambda+s\lambda$、$(rs)\lambda=r(s\lambda)$、
  $r(\lambda+\mu)=r\lambda+r\mu$、$1\cdot\lambda=\lambda$ を有理数 4 個で検査する。
- 密度の住処の例: $L=2$、$q=3/2$ の $\Phi_L(q)$ を素因数分解で作り、$\tfrac{1}{4}\cdot\iota(\Phi_L(q))$ の
  各値が `QQ` の元であることを確かめる。

## Lean

具体版 `toRational_add`・`toRational_injective`、必要十分版 `pointwise_lift_add_and_injective_necSuf`、
導出版を `lean/Ising2DLambda/ThermodynamicLimit/RationalLogOrderGroup.lean`、
`lean/Ising2DLambda/NecSuf/ThermodynamicLimit/RationalLogOrderGroup.lean`、
`lean/Ising2DLambda/ThermodynamicLimit/RationalLogOrderGroupFromNecSuf.lean` に置く（2026-08-15）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-log-order-group-embedding/check.sage
```
