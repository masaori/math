# SageMath Check: sine_of_half_pi_is_one

## 対象

**対象ラベル**: `sine_of_half_pi_is_one` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_sine_of_half_pi_is_one`（sin(π/2) = 1）
- 範囲: 鎖の二行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目（`arcsin_of_one_is_half_pi` を右辺から左辺へ: π/2 = arcsin(1)） | `check_proof_lines.sage` | Sage の記号計算で arcsin(1) = π/2、RealBallField(256) のボールでも π/2 を含む | **PASS** | 成り立つ |
| 2 行目（`arcsin_is_bijection` の値域と `def_sin` の y の一意性） | `check_proof_lines.sage` | sin(π/2) を AA（e^{iπ/2} の虚部）で作り 1 と一致、y = 1 で arcsin(y) が π/2 のボールと重なる。y を 0・−1 に取り違えると arcsin(y) < π/2 になる否定の対照 | **PASS** | 成り立つ |
| 主張 | `check_proof_lines.sage` | AA で厳密に | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: sin(π/2) は 1 の 4 乗根の虚部として `AA` で作る（共通の準備 `sagemath/_shared/sine_cosine_by_definition.sage`）。
- **ℝ へ脱出**: arcsin(1) と π の比較は `RealBallField(256)` のボールで行う（π と弧の長さが実数だから。ボールの比較は真と判定できたときだけ真を返す）。

範囲外のもの:

- 本文の arcsin（弧の長さ）が標準の arcsin と一致することは `arcsin_is_bijection`・`arcsin_of_one_is_half_pi` の検算が扱う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sine_of_half_pi_is_one
```

実行ログは `logs/` に保存する。
