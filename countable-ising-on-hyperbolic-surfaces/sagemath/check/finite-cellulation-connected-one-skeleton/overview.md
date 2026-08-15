# 一次骨格連結述語の検算

**対象ラベル**: `def_finite_cellulation_connected_one_skeleton`

## 対象

- 構造化本文: 「一次骨格の連結性を判定する有限述語」
- 検算範囲: 端点写像を通じた有限頂点集合上の到達可能性が全頂点を覆うという有限述語
- 帰属: 有限集合、自然数、真偽値。浮動小数点と非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check.sage` | 二面三角形の球面の一次骨格を受理し、互いに素な二つの三角形の一次骨格を拒否する | PASS | 二つの有限入力で期待する真偽値と一致した |

実行日: 2026-08-15

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/finite-cellulation-connected-one-skeleton/check.sage
```
