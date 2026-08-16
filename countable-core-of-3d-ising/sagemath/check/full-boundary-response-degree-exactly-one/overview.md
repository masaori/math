# SageMath Check: 辺変数を 1 に置かない境界応答多項式は各辺の変数に真に依存する（次数はちょうど 1）

## 対象

**対象ラベル**: `claim_full_boundary_response_degree_exactly_one`

- 内箱 $V_{L'}=\{(0,0,0)\}$、外箱 $V_L=\{0,1\}^3$（8 点・12 辺）の自由境界の箱で、本文の証明を一段ずつ確認する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_degree_exactly_one.sage` | 任意の $e_0\in E_L$ について、$\partial_1 e_0$ だけを $-1$ にした配位 $\tau$ が $e_0\in B(\tau)$ を満たすこと、相異なる破れ辺集合の単項式が相異なること、$\tau$ の単項式の $\widetilde R_{L,L'}$ における係数が $B(\sigma)=B(\tau)$ となる配位の個数（自然数、$1$ 以上）であること、その単項式の $X_{e_0}$ の指数が $1$ で次数が $1$ 以上であること、高々 $1$ と合わせてちょうど $1$ であること | PASS | $2^{8}$ 配位の有限和で全 12 辺の次数がちょうど $1$ |

## 備考

- すべて `ZZ` 上の多変数多項式環の厳密計算であり、浮動小数点・極限・無限和は使わない。
- 高々 1 の側は `sagemath/check/full-boundary-response-degree-at-most-one/` で別に確認済み。

```sh
sage sagemath/check/full-boundary-response-degree-exactly-one/check_degree_exactly_one.sage
```

**2026-08-16 実行: PASS。**
