# -*- mode: python ; coding: utf-8 -*-

block_cipher = None


a = Analysis(['IMMLabelPrinter.py'],
             pathex=['D:\\03-Work\\Yinzhi\\02_M\\00_脚本\\16_斑马打印机\\0_IMMPrinter\\development'],
             binaries=[],
             datas=[],
             hiddenimports=['decimal'],
             hookspath=[],
             runtime_hooks=[],
             excludes=[],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher,
             noarchive=False)
pyz = PYZ(a.pure, a.zipped_data,
             cipher=block_cipher)
exe = EXE(pyz,
          a.scripts,
          a.binaries,
          a.zipfiles,
          a.datas,
          [],
          name='IMMLabelPrinter',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=True,
          upx_exclude=[],
          runtime_tmpdir=None,
          console=False )
