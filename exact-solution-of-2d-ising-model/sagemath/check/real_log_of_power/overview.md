# SageMath Check: real_log_of_power

## 対象

**対象ラベル**: `real_log_of_power` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_real_log_of_power`（a ∈ ℝ_{>0}、n ∈ Z_{≥1} なら a^n ∈ ℝ_{>0} かつ log(a^n) = n log a。冪は `def_power_of_real_number` の a^0 := 1、a^{m+1} := a^m a）
- 範囲: n = 1 の二つの鎖（三行と二行）、帰納の段の a^{n+1} ∈ ℝ_{>0} と四行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| n = 1: `a^1 = a^0 a = 1·a = a`、`log(a^1) = log a = 1·log a` | `check_proof_lines.sage` | 冪を定義の再帰で作って三つの等号（QQ・AA の厳密な比較）、log の二つの等号（ボール） | **PASS** |
| 帰納の段: 仮定 `a^n > 0`・`log(a^n) = n log a`、`a^{n+1} = a^n a > 0` | `check_proof_lines.sage` | `a^{n+1}` を再帰で作り、`a^n a` と Sage 組み込みの `a**(n+1)` に一致し正であること（QQ・AA の厳密な比較） | **PASS** |
| 帰納の段の鎖 `log(a^{n+1}) = log(a^n a) = log(a^n) + log a = n log a + log a = (n+1) log a` | `check_proof_lines.sage` | 各行の両辺を別々にボールで作って等号、鎖の両端も | **PASS** |
| 主張 | `check_proof_lines.sage` | a ∈ {1, 2, 1/3, 10^{-6}, 123/7, √2, √2+√3, √5−2}、n = 1..40 | **PASS** |

比較は 1600 個。否定コントロール: `a = 2, 1/3, √2+√3`、`n = 2..5` で `log(a^n)` は `(n+1) log a` とも `(log a)^n` とも一致しない。

## 計算の帰属と範囲

- **厳密**: 冪の値、`a^{n+1} = a^n a`、正値性は QQ・AA（実代数的数）の比較である。
- **ℝ への脱出（`RealBallField(512)`）**: log の値だけ。値が QQ・AA に入らないためである（実対数による脱出）。log は Arb の log
  （本文の log は exp の逆写像で、本文の exp は標準の実数の exp に等しい）。等号は差のボールが 0 を含み半径が 2^-200 未満であることで判定し、
  許容誤差は置かない（共通の準備 `sagemath/_shared/log_integral_by_balls.sage`）。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- n = 1 の二つの鎖と、帰納の段の 1 行目（`a^{n+1}` を `a^n a` として作るため）・4 行目（ボールの分配法則）。
- 中身は 2 行目（`real_log_of_product`。冪の値の log と log の和を別々に計算する）、3 行目（別に計算した log(a^n) と n log a を比べる帰納法の仮定）と、鎖の両端 `log(a^{n+1}) = (n+1) log a` にある。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_log_of_power
```

実行ログは `logs/` に保存する。
