/*
 * Updated by RESONANCE JSC, Bludov Dmitriy,
 * void print1Line(View view) - 23.01.2109
 * void print2Lines(View view) - 23.01.2109
 */

package com.sunmi.testlcd;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.os.IBinder;
import android.os.RemoteException;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import woyou.aidlservice.jiuiv5.IWoyouService;

public class MainActivity extends AppCompatActivity {
    private IWoyouService woyouService;
    private ServiceConnection connService = new ServiceConnection() {

        @Override
        public void onServiceDisconnected(ComponentName name) {
            woyouService = null;
        }

        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            woyouService = IWoyouService.Stub.asInterface(service);
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Intent intent = new Intent();
        intent.setPackage("woyou.aidlservice.jiuiv5");
        intent.setAction("woyou.aidlservice.jiuiv5.IWoyouService");
        bindService(intent, connService, Context.BIND_AUTO_CREATE);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        unbindService(connService);
    }

    public void makeLCDInit(View view) {
        if (woyouService == null) {
            Toast.makeText(this, "Service not ready", Toast.LENGTH_SHORT).show();
            return;
        }

        try {
            woyouService.sendLCDCommand(1);
        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }

    public void makeLCDWakeup(View view) {
        if (woyouService == null) {
            Toast.makeText(this, "Service not ready", Toast.LENGTH_SHORT).show();
            return;
        }

        try {
            woyouService.sendLCDCommand(2);
            //woyouService.sendLCDDoubleString("Total:€999.99", "Change:¥999.99", null);
        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }

    public void makeLCDSleep(View view) {
        if (woyouService == null) {
            Toast.makeText(this, "Service not ready", Toast.LENGTH_SHORT).show();
            return;
        }

        try {
            woyouService.sendLCDCommand(3);
        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }

    public void makeLCDClear(View view) {
        if (woyouService == null) {
            Toast.makeText(this, "Service not ready", Toast.LENGTH_SHORT).show();
            return;
        }

        try {
            woyouService.sendLCDCommand(4);
        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }

    public void sendText(View view) {
        if (woyouService == null) {
            Toast.makeText(this, "Service not ready", Toast.LENGTH_SHORT).show();
            return;
        }

        try {
            woyouService.sendLCDString("Sunmi!", null);
        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }

    public void sendPicture(View view) {
        if (woyouService == null) {
            Toast.makeText(this, "Service not ready", Toast.LENGTH_SHORT).show();
            return;
        }

        try {
            woyouService.sendLCDBitmap(BitmapFactory.decodeResource(getResources(), R.mipmap.sunmi), null);
        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }

    public void show1Line(View view) {
        if (woyouService == null) {
            Toast.makeText(this, "Service not ready", Toast.LENGTH_SHORT).show();
            return;
        }

        try {
            EditText firstLine = findViewById(R.id.edit_firstString);
            woyouService.sendLCDString(firstLine.getText().toString(), null);
            woyouService.sendLCDCommand(2);
        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }

    public void show2Lines(View view) {
        if (woyouService == null) {
            Toast.makeText(this, "Service not ready", Toast.LENGTH_SHORT).show();
            return;
        }

        try {
            EditText firstLine = findViewById(R.id.edit_firstString);
            EditText secondLine = findViewById(R.id.edit_secondString);
            woyouService.sendLCDDoubleString(firstLine.getText().toString(),
                    secondLine.getText().toString(),
                    null);
            woyouService.sendLCDCommand(2);
        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }

}