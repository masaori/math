# SageMath Check: cosine_zero

## 対象

**対象ラベル**: `cosine_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_cosine_zero`（cos 0 = 1）
- 範囲: 鎖の六行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1・2 行目（def_cos の θ → 0（0 ∈ [−π/2, π/2] は zero_in_closed_interval_from_minus_half_pi_to_half_pi）・sine_zero） | `check_proof_lines.sage` | AA で厳密に | **PASS** | 成り立つ |
| 3〜5 行目（square_of_real_number_is_product（r → 0）・ℝ で 0·x = 0（x → 0）・ℝ で a − 0 = a（a → 1）） | `check_proof_lines.sage` | AA で各行の事実と値。取り違えた値との否定の対照 | **PASS** | 成り立つ |
| 6 行目（`sqrt_of_real_one_is_one`: 1 は 1 の非負平方根） | `check_proof_lines.sage` | AA で 1 ≥ 0 と 1² = 1 | **PASS** | 成り立つ |
| 主張 | `check_proof_lines.sage` | AA。e^{i·0} の実部とも一致 | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: すべての行を `AA` で確かめた（sin 0 は 1 の冪根の虚部、平方根は `AA` の非負平方根。共通の準備 `sagemath/_shared/sine_cosine_by_definition.sage`）。1・2 行目は定義を当てはめる行なので、定義の書き写しの誤りだけを検出する。

範囲外のもの:

- なし（全行を厳密に確かめた）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh cosine_zero
```

実行ログは `logs/` に保存する。
