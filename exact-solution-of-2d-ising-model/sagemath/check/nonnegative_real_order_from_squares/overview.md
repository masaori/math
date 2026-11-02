# SageMath Check: nonnegative_real_order_from_squares

## 対象

**対象ラベル**: `nonnegative_real_order_from_squares` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_nonnegative_real_order_from_squares`（u, v ∈ ℝ_{≥0} で u² ≤ v² なら u ≤ v）
- 範囲: 背理法の鎖の 4 行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| v² = v·v、u·u = u² | `check_proof_lines.sage` | QQ[u, v] の等号 | **PASS** | 成り立つ |
| v·v ≤ v·u、v·u < u·u | `check_proof_lines.sage` | 差を v(u - v)、u(u - v) に因数分解（QQ[u, v]）し、仮定 0 ≤ v < u の下で符号が決まることを見る。AA の 9 点の組のうち v < u の 36 組で各行を厳密に | **PASS** | 成り立つ |
| 主張 | `check_proof_lines.sage` | AA の 9 点の組のうち u² ≤ v² の 45 組で u ≤ v | **PASS** | 成り立つ |
| 対照 | `check_proof_lines.sage` | v ≥ 0 を外すと成り立たない（u = 1, v = -2） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: すべて QQ[u, v] と AA（実代数的数）で確かめた。浮動小数点は使わない。
- 範囲外: 選んだ以外の点。背理法の鎖は仮定 v < u の下でしか意味を持たないので、仮定を満たす点の組だけで確かめた。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh nonnegative_real_order_from_squares
```

実行ログは `logs/` に保存する。
