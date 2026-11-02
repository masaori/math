# SageMath Check: real_log_of_product

## 対象

**対象ラベル**: `real_log_of_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_real_log_of_product`（a, b > 0 なら log(ab) = log a + log b）
- 範囲: 準備の鎖の二行と主張の鎖の二行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の 1 行目（exp の積の法則） | `check_proof_lines.sage` | 引数を QQ[u,v] の不定元に置き、本文の exp の部分和を全次数 14 以下の形式冪級数で比べる | **PASS** | 成り立つ |
| 準備の 2 行目（exp(log y) = y を 2 箇所へ） | `check_proof_lines.sage` | 5 組の (a, b) ∈ QQ_{>0}² で、本文の exp のボールが a・b・ab を含む | **PASS** | 成り立つ |
| 主張の鎖の両端 | `check_proof_lines.sage` | 同じ 5 組で log(ab) と log a + log b を別々にボールで計算して一致 | **PASS** | 成り立つ |
| 対照 | `check_proof_lines.sage` | log(1+1) は log 1 + log 1 と異なる | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: exp の積の法則の行は `QQ[u,v]` の形式冪級数（全次数 14 以下）で確かめた。
- **`ℝ` への脱出（`RealBallField(512)`）**: log の値（Arb の log。本文の log は exp の逆写像で、本文の exp は標準の実数の exp に等しい）と exp の値（本文の部分和に尾の評価を半径として足したボール）だけ。値が QQ に入らないためである。判定は差のボールの下端の符号（大小）と、差のボールが 0 を含み半径が 2^-200 未満であること（等号）で行い、許容誤差は置かない（共通の準備 `sagemath/_shared/log_integral_by_balls.sage`）。

範囲外のもの:

- 選んだ以外の点。微分の公式・(R3)・(R4)・円周率の数値の評価そのもの（本文が外部から持ち込む事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_log_of_product
```

実行ログは `logs/` に保存する。
