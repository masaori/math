# SageMath Check: nonzero_kernel_iff_det_zero_two_by_two

## 対象

**対象ラベル**: `nonzero_kernel_iff_det_zero_two_by_two` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_45_46.ts`
  （ブロック `finite_matrix_claim_nonzero_kernel_iff_determinant_zero_two_by_two`）
- 主張（2×2 行列が 0 でないベクトルを 0 へ送ることと行列式が 0 であることの同値）: `B ∈ Mat(2,ℂ)` について
  `(∃ v ∈ ℂ², v ≠ 0 かつ Bv = 0) ⟺ det B = 0`（`det B := B_{11}B_{22} − B_{12}B_{21}`、`def_det_two_by_two`）
- 範囲: 証明の「⇒」の 2 本の鎖と、「⇐」の 3 つの場合の成分の鎖の各行。あわせて、この主張を引く
  `eigenvector_of_A_theta_tilde` Step 1 の同値の鎖のうち、ベクトルの恒等式 `Av − λv = Av − λ(Iv) = Av − (λI)v = (A − λI)v` を確かめる。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_steps.sage | (⇒) 2 本の鎖の各行が `QQ[B11, B12, B21, B22, v1, v2]` の多項式として一致すること。(⇐) 3 つの場合の `Bv` の成分の各行（1 行目が零でない場合の第 2 成分が `−det B` になること、1 行目が零の場合の第 1 成分が `B_{11} = B_{12} = 0` の代入で 0 になること）。否定コントロール: `v = (B_{12}, B_{11})` では `(Bv)_1 = 2B_{11}B_{12} ≠ 0`。同値そのものの全数検査（成分 `∈ {−2,…,2}` の 625 個、`QQ` 上の核の次元と `det` の比較）。Step 1 の `Av − λv = Av − λ(Iv) = Av − (λI)v = (A − λI)v`。具体例 4 個で `det(A − λI) = 0` の根と固有値の集合が `QQbar` で一致すること | PASS | すべて厳密に一致 |

## 備考

- 浮動小数点は使っていない。多項式環 `QQ[...]` の恒等式と、`QQ`・`QQbar` の厳密計算だけで確かめた。

## 実行方法

```bash
cd sagemath/check/nonzero_kernel_iff_det_zero_two_by_two
~/micromamba/envs/sage/bin/sage check_steps.sage
```

実行ログは `logs/` に保存してある（2026-11-01）。
