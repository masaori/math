# 双曲正則型をもつ有限セル分割の負の Euler 標数の検算

**対象ラベル**: `theorem_hyperbolic_regular_type_negative_euler_characteristic`

## 対象

- 構造化本文: 「双曲正則型をもつ有限セル分割の負の Euler 標数」
- 検算範囲: 双曲不等式の整数移送、Euler incidence 係数の負性、正の辺数との積、Euler 標数の負性
- 帰属: 全て `NN` と `ZZ`。除算、実数、複素数、浮動小数点、極限、積分を用いない

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_hyperbolic_inequality_embedding.sage` | 自然数の双曲不等式を整数へ移す | PASS | 固定剰余類セル分割の型 `(3,7)` で一致 |
| `check_negative_coefficient.sage` | `2p+2q-pq<0` を導く | PASS | 整数の順序比較が一致 |
| `check_negative_product.sage` | 負の係数と正の辺数の積が負になることを導く | PASS | 辺数 `84` で一致 |
| `check_euler_negativity.sage` | Euler incidence 等式から `chi_cell<0` を導く | PASS | Euler 標数 `-4` で一致 |

## 有限例

- 固定剰余類双曲セル分割: `(p,q,|V|,|E|,|F|)=(3,7,24,84,56)`

## 実行履歴

- ERROR: 初回は `structured-latex/` を作業ディレクトリとしてリポジトリ直下相対の glob を渡したため、対象 `.sage` ファイルを解決できなかった。
- PASS: リポジトリ直下から同じ四検算を実行し、全件が終了コード `0` で完了した。

## 実行方法

```bash
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-negative-euler-characteristic/check_*.sage; do
  sage "$f"
done
```
