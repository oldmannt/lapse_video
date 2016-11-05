// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

package dyno.fun.lapse;

import java.util.concurrent.atomic.AtomicBoolean;

public abstract class MoiveInfoGen {
    public abstract String getName();

    public abstract int getFrameAmount();

    public abstract float getDurationSecond();

    public abstract float getFPS();

    public abstract float getRecordLapse();

    public abstract float getRecordDuration();

    public abstract boolean setName(String name);

    public abstract void setFrameAmount(int amount);

    public abstract void setDurationSecond(float seconds);

    public abstract void setFPS(float fps);

    public abstract void setRecordDuration(float duration);

    public abstract void setRecordLapse(float lapse);

    private static final class CppProxy extends MoiveInfoGen
    {
        private final long nativeRef;
        private final AtomicBoolean destroyed = new AtomicBoolean(false);

        private CppProxy(long nativeRef)
        {
            if (nativeRef == 0) throw new RuntimeException("nativeRef is zero");
            this.nativeRef = nativeRef;
        }

        private native void nativeDestroy(long nativeRef);
        public void destroy()
        {
            boolean destroyed = this.destroyed.getAndSet(true);
            if (!destroyed) nativeDestroy(this.nativeRef);
        }
        protected void finalize() throws java.lang.Throwable
        {
            destroy();
            super.finalize();
        }

        @Override
        public String getName()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getName(this.nativeRef);
        }
        private native String native_getName(long _nativeRef);

        @Override
        public int getFrameAmount()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getFrameAmount(this.nativeRef);
        }
        private native int native_getFrameAmount(long _nativeRef);

        @Override
        public float getDurationSecond()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getDurationSecond(this.nativeRef);
        }
        private native float native_getDurationSecond(long _nativeRef);

        @Override
        public float getFPS()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getFPS(this.nativeRef);
        }
        private native float native_getFPS(long _nativeRef);

        @Override
        public float getRecordLapse()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getRecordLapse(this.nativeRef);
        }
        private native float native_getRecordLapse(long _nativeRef);

        @Override
        public float getRecordDuration()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getRecordDuration(this.nativeRef);
        }
        private native float native_getRecordDuration(long _nativeRef);

        @Override
        public boolean setName(String name)
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_setName(this.nativeRef, name);
        }
        private native boolean native_setName(long _nativeRef, String name);

        @Override
        public void setFrameAmount(int amount)
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            native_setFrameAmount(this.nativeRef, amount);
        }
        private native void native_setFrameAmount(long _nativeRef, int amount);

        @Override
        public void setDurationSecond(float seconds)
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            native_setDurationSecond(this.nativeRef, seconds);
        }
        private native void native_setDurationSecond(long _nativeRef, float seconds);

        @Override
        public void setFPS(float fps)
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            native_setFPS(this.nativeRef, fps);
        }
        private native void native_setFPS(long _nativeRef, float fps);

        @Override
        public void setRecordDuration(float duration)
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            native_setRecordDuration(this.nativeRef, duration);
        }
        private native void native_setRecordDuration(long _nativeRef, float duration);

        @Override
        public void setRecordLapse(float lapse)
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            native_setRecordLapse(this.nativeRef, lapse);
        }
        private native void native_setRecordLapse(long _nativeRef, float lapse);
    }
}