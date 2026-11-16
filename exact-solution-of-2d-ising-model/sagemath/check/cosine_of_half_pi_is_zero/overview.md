# SageMath Check: cosine_of_half_pi_is_zero

## 対象

**対象ラベル**: `cosine_of_half_pi_is_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_cosine_of_half_pi_is_zero`（cos(π/2) = 0）
- 範囲: 鎖の五行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目（`def_cos` の θ → π/2。π/2 ∈ [−π/2, π/2] は `arcsin_of_one_is_half_pi` と `arcsin_is_bijection` の値域） | `check_proof_lines.sage` | arcsin(1) = π/2 を記号計算とボールで、定義の当てはめを AA で | **PASS** | 成り立つ |
| 2 行目（`sine_of_half_pi_is_one`） | `check_proof_lines.sage` | AA で sin(π/2) = 1 | **PASS** | 成り立つ |
| 3・4 行目（`power_of_real_one_is_one`（m → 2）・ℝ で a − a = 0（a → 1）） | `check_proof_lines.sage` | AA で各行の事実と値。取り違えた値との否定の対照 | **PASS** | 成り立つ |
| 5 行目（`sqrt_of_real_zero_is_zero`） | `check_proof_lines.sage` | AA で 0 ≥ 0 と 0² = 0 | **PASS** | 成り立つ |
| 主張 | `check_proof_lines.sage` | AA。e^{iπ/2} の実部とも一致 | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 鎖のすべての行を `AA` で確かめた（共通の準備 `sagemath/_shared/sine_cosine_by_definition.sage`）。1・2 行目は定義と主張を当てはめる行なので、書き写しの誤りだけを検出する。
- **ℝ へ脱出**: 1 行目の定義域の理由 arcsin(1) = π/2 のボールの比較だけ（π が実数だから）。

範囲外のもの:

- なし。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh cosine_of_half_pi_is_zero
```

実行ログは `logs/` に保存する。
