# 有限第一ホモロジー群の `F_2` 値文字空間の検算

**対象ラベル**: `def_f2_linear_character_space`

## 対象

- ファイル: `structured-latex/content/finite-fourier-duality.ts`（ブロック `finite_fourier_definition_f2_linear_character_space`）
- 範囲: 次元 `0` から `4` の有限 `F_2` ベクトル空間について、係数ベクトルが定める全ての文字が本文の線形性条件を満たし、相異なる文字の個数が `2^dimension` であること

## チェック一覧

実行日: 2026-08-16

| ファイル | 内容 | 状態 | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | 次元 `0` から `4` の全係数ベクトルについて線形性条件を全てのスカラー対・元対で照合する | PASS | 各次元で相異なる文字が `2^dimension` 個あり、全て零元を `0` へ送った |

## 備考

- 非可算への脱出はない。`GF(2)` の厳密演算だけを用いた。
- 初回実行は可変な SageMath ベクトルを辞書キーに用いたため `TypeError: mutable vectors are unhashable` で `ERROR` となった。写像を関数評価として実装し直した後、同じ数学的条件で `PASS` した。
- 全検証の初回呼び出しは `structured-latex/` からリポジトリルート相対パスを渡したため、対象ファイル未検出で `ERROR` となった。作業ディレクトリに対する相対パスを `../sagemath/check/f2-linear-character-space/check_definition.sage` へ直して再実行し、`PASS` した。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/f2-linear-character-space/check_definition.sage
```

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/f2-linear-character-space/check_*.sage; do
  sage "$f"
done
```
