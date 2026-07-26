# SageMath Check: 115_isomorphism_of_phi_cartesian

## 対象

**対象ラベル**: `isomorphism_of_phi_cartesian` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.mjs`

- 範囲: φ_cartesian が積を保つこと（モノイド準同型）と全単射性

極座標表現の積 [(r,θ)]·[(r′,θ′)] = [(rr′,θ+θ′)] を φ_cartesian で送ったものと、送ってから掛けたものを比べる。全単射性は φ_polar が逆写像であることで確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_homomorphism.sage` | 積の保存、φ_cartesian∘φ_polar = id、代表元の一致 | 791 | 1.839e-15 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

r = 0 の同値類（すべての θ が同一視される）を含むサンプルを入れている。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 115
```

実行ログは `sagemath/check/115_isomorphism_of_phi_cartesian/logs/` に保存してある（この表の数値はそのログから取った）。
