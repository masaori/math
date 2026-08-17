# 主第一コホモロジーから双対第一ホモロジーへの誘導写像の全単射性の検算

**対象ラベル**: `theorem_primal_cohomology_dual_homology_transport_is_bijective`

## 対象

- ファイル: `structured-latex/content/finite-fourier-duality.ts`（ブロック `finite_fourier_theorem_primal_cohomology_dual_homology_transport_is_bijective`）
- 範囲: 主辺から双対辺への係数移送の逆写像、逆写像による双対サイクルと双対面境界の移送、および商上の誘導写像の左右逆写像性
- 併せて検証: `def_primal_cohomology_to_dual_homology_transport`、`theorem_primal_coboundary_transport_is_dual_boundary`

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_inverse_cycle_and_boundary.sage` | 全ての双対一次サイクルが逆向き係数移送で主一次コサイクルへ入り、双対面境界空間が主一次余境界空間へちょうど戻ることを全列挙する | PASS | サイクルの帰属と二つの境界空間の等号が全て一致した |
| `check_inverse_compositions.sage` | 全ての主一次コサイクルと双対一次サイクルについて、係数移送と逆向き係数移送の左右合成が恒等写像になることを照合する | PASS | 全ての係数写像で左右合成が元の係数写像と一致した |
| `check_quotient_bijection.sage` | 主第一コホモロジーと双対第一ホモロジーの全ての剰余集合について、商上の二写像が左右逆写像であることを照合する | PASS | 二つの誘導写像は互いに逆で、両方の商集合を全射的に覆った |

## 備考

- 有限集合と `GF(2)` の等号だけを用いる厳密検算である。
- 非可算への脱出はない。浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/primal-cohomology-dual-homology-transport-is-bijective/check_*.sage; do
  sage "$f"
done
```
