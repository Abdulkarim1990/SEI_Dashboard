import { Button } from "./components/ui/button";
import { Badge } from "./components/ui/badge";
import { MapPin, Target, TrendingUp, Users2, GraduationCap, BarChart2, Laptop, UsersRound, FileText, Heart, Tablet, Eye } from "lucide-react";
import { ImageWithFallback } from "./components/figma/ImageWithFallback";
import heroImage from "figma:asset/df430e0330fb039c913892d600971f00460cb53d.png";
import studentsImage from "figma:asset/2c0fbe021014b9c1ef95c32200702bd308a41e67.png";
import studentPortraitImage from "figma:asset/53d192285350a922ddb2ae35bedce6b4150afced.png";

export default function App() {
  const dashboardUrl = "https://t-tel.shinyapps.io/secondary_reform/";

  return (
    <div className="min-h-screen bg-white">
      {/* Hero Section - Full screen with image background */}
      <section className="relative h-screen flex items-center justify-center overflow-hidden">
        <div className="absolute inset-0 bg-black/40 z-10"></div>
        <ImageWithFallback
          src={heroImage}
          alt="Ghanaian students in classroom"
          className="absolute inset-0 w-full h-full object-cover"
        />
        <div className="relative z-20 text-center px-4 max-w-4xl mx-auto">
          <div className="mb-6 inline-flex items-center gap-2 bg-yellow-500 text-black px-4 py-2 rounded-full">
            <MapPin className="size-4" />
            <span className="font-medium">Secondary Education Reform</span>
          </div>
          <h1 className="text-5xl md:text-7xl font-bold text-white mb-6 leading-tight">
            Shaping Ghana's Future<br />One Student at a Time
          </h1>
          <p className="text-xl md:text-2xl text-white/90 mb-10 max-w-2xl mx-auto">
            Track the transformation of secondary education across Ghana through real data and measurable impact
          </p>
          <Button 
            size="lg" 
            className="bg-yellow-500 hover:bg-yellow-600 text-black text-lg px-8 py-6 h-auto"
            asChild
          >
            <a href={dashboardUrl} target="_blank" rel="noopener noreferrer">
              Explore the Dashboard
            </a>
          </Button>
        </div>
      </section>

      {/* Stats Bar */}
      <section className="bg-gradient-to-r from-red-600 via-yellow-500 to-green-600 py-12">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-8 text-center">
            <div className="text-white">
              <div className="text-4xl font-bold mb-2">16</div>
              <div className="text-sm uppercase tracking-wide">Regions</div>
            </div>
            <div className="text-white">
              <div className="text-4xl font-bold mb-2">721</div>
              <div className="text-sm uppercase tracking-wide">Secondary Schools</div>
            </div>
            <div className="text-white">
              <div className="text-4xl font-bold mb-2">1.2 million +</div>
              <div className="text-sm uppercase tracking-wide">Students</div>
            </div>
            <div className="text-white">
              <div className="text-4xl font-bold mb-2">2026</div>
              <div className="text-sm uppercase tracking-wide">Active Dashboard</div>
            </div>
          </div>
        </div>
      </section>

      {/* Mission Section */}
      <section className="py-24 bg-slate-50">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <Badge variant="outline" className="mb-4 text-base px-4 py-1">Our Mission</Badge>
            <h2 className="text-4xl font-bold text-slate-900 mb-6">
              Transforming Ghana's Secondary Education 
            </h2>
            <p className="text-xl text-slate-600 leading-relaxed max-w-3xl mx-auto">
              This dashboard provides comprehensive insights into the ongoing reforms across Ghana's secondary education sector. 
              By making data transparent and accessible, we empower policymakers, educators and communities to drive meaningful change.
            </p>
          </div>

          <div className="grid md:grid-cols-3 gap-8 mt-16">
            <div className="text-center p-8 bg-white rounded-xl shadow-sm hover:shadow-md transition-shadow">
              <div className="size-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <Target className="size-8 text-red-600" />
              </div>
              <h3 className="text-xl font-bold mb-3">Measure Impact</h3>
              <p className="text-slate-600">
                Track the real-world outcomes of reform policies across all regions of Ghana
              </p>
            </div>

            <div className="text-center p-8 bg-white rounded-xl shadow-sm hover:shadow-md transition-shadow">
              <div className="size-16 bg-yellow-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <TrendingUp className="size-8 text-yellow-600" />
              </div>
              <h3 className="text-xl font-bold mb-3">Drive Progress</h3>
              <p className="text-slate-600">
                Identify trends and opportunities to accelerate educational improvement
              </p>
            </div>

            <div className="text-center p-8 bg-white rounded-xl shadow-sm hover:shadow-md transition-shadow">
              <div className="size-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <Users2 className="size-8 text-green-600" />
              </div>
              <h3 className="text-xl font-bold mb-3">Unite Stakeholders</h3>
              <p className="text-slate-600">
                Bring together government, schools and communities with shared data
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Image Split Section */}
      <section className="bg-white">
        <div className="grid lg:grid-cols-2">
          <div className="relative h-96 lg:h-auto">
            <ImageWithFallback
              src={studentsImage}
              alt="Students studying"
              className="absolute inset-0 w-full h-full object-cover"
            />
          </div>
          <div className="flex items-center p-12 lg:p-16">
            <div className="space-y-6">
              <Badge className="bg-green-600">What's Inside</Badge>
              <h2 className="text-4xl font-bold text-slate-900">
                Track Every Aspect of Reform Implementation
              </h2>
              <div className="space-y-4">
                <div className="flex gap-4 items-start">
                  <div className="flex-shrink-0 size-10 bg-blue-100 rounded-lg flex items-center justify-center mt-1">
                    <UsersRound className="size-5 text-blue-600" />
                  </div>
                  <div>
                    <h3 className="font-bold text-lg mb-1">PLC & VLC Attendance</h3>
                    <p className="text-slate-600">Monitor Professional and Virtual Learning Community participation rates</p>
                  </div>
                </div>
                <div className="flex gap-4 items-start">
                  <div className="flex-shrink-0 size-10 bg-purple-100 rounded-lg flex items-center justify-center mt-1">
                    <Eye className="size-5 text-purple-600" />
                  </div>
                  <div>
                    <h3 className="font-bold text-lg mb-1">Lesson Observation Summary</h3>
                    <p className="text-slate-600">Track teaching quality and classroom practices across schools</p>
                  </div>
                </div>
                <div className="flex gap-4 items-start">
                  <div className="flex-shrink-0 size-10 bg-green-100 rounded-lg flex items-center justify-center mt-1">
                    <Tablet className="size-5 text-green-600" />
                  </div>
                  <div>
                    <h3 className="font-bold text-lg mb-1">Tablet Distribution</h3>
                    <p className="text-slate-600">Monitor digital learning device rollout across secondary schools</p>
                  </div>
                </div>
                <div className="flex gap-4 items-start">
                  <div className="flex-shrink-0 size-10 bg-orange-100 rounded-lg flex items-center justify-center mt-1">
                    <Laptop className="size-5 text-orange-600" />
                  </div>
                  <div>
                    <h3 className="font-bold text-lg mb-1">ICT Integration in SHS</h3>
                    <p className="text-slate-600">Measure technology adoption and digital literacy progress</p>
                  </div>
                </div>
              </div>
              <Button 
                className="bg-slate-900 hover:bg-slate-800 text-white mt-8"
                asChild
              >
                <a href={dashboardUrl} target="_blank" rel="noopener noreferrer">
                  View Dashboard
                </a>
              </Button>
            </div>
          </div>
        </div>
      </section>

      {/* Another Image Split - Reversed */}
      <section className="bg-slate-50">
        <div className="grid lg:grid-cols-2">
          <div className="flex items-center p-12 lg:p-16 order-2 lg:order-1">
            <div className="space-y-6">
              <Badge className="bg-yellow-600">For Decision Makers</Badge>
              <h2 className="text-4xl font-bold text-slate-900">
                Evidence-Based Policy Making
              </h2>
              <p className="text-lg text-slate-600 leading-relaxed">
                Ghana's secondary education reform requires informed decisions backed by reliable data. 
                This dashboard provides the evidence needed to:
              </p>
              <ul className="space-y-3 text-slate-700">
                <li className="flex items-start gap-3">
                  <span className="flex-shrink-0 size-6 bg-green-600 text-white rounded-full flex items-center justify-center text-sm font-bold mt-1">✓</span>
                  <span>Allocate resources where they're needed most</span>
                </li>
                <li className="flex items-start gap-3">
                  <span className="flex-shrink-0 size-6 bg-green-600 text-white rounded-full flex items-center justify-center text-sm font-bold mt-1">✓</span>
                  <span>Identify schools and regions requiring additional support</span>
                </li>
                <li className="flex items-start gap-3">
                  <span className="flex-shrink-0 size-6 bg-green-600 text-white rounded-full flex items-center justify-center text-sm font-bold mt-1">✓</span>
                  <span>Monitor the success of educational interventions</span>
                </li>
                <li className="flex items-start gap-3">
                  <span className="flex-shrink-0 size-6 bg-green-600 text-white rounded-full flex items-center justify-center text-sm font-bold mt-1">✓</span>
                  <span>Plan for the future of Ghana's education sector</span>
                </li>
              </ul>
            </div>
          </div>
          <div className="relative h-96 lg:h-auto order-1 lg:order-2">
            <ImageWithFallback
              src={studentPortraitImage}
              alt="Ghana education"
              className="absolute inset-0 w-full h-full object-cover"
            />
          </div>
        </div>
      </section>

      {/* Key Metrics Grid */}
      <section className="py-24 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <Badge variant="outline" className="mb-4 text-base px-4 py-1">Dashboard Metrics</Badge>
            <h2 className="text-4xl font-bold text-slate-900 mb-6">
              Comprehensive Reform Tracking
            </h2>
            <p className="text-xl text-slate-600 max-w-3xl mx-auto">
              Monitor all critical aspects of Ghana's secondary education reform initiative in one centralised platform
            </p>
          </div>

          <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
            <div className="bg-gradient-to-br from-blue-50 to-blue-100 rounded-xl p-6 border-2 border-blue-200">
              <div className="size-12 bg-blue-600 rounded-lg flex items-center justify-center mb-4">
                <UsersRound className="size-6 text-white" />
              </div>
              <h3 className="font-bold text-lg mb-2">PLC Attendance Rate</h3>
              <p className="text-slate-600 text-sm">Professional Learning Community participation and engagement tracking</p>
            </div>

            <div className="bg-gradient-to-br from-purple-50 to-purple-100 rounded-xl p-6 border-2 border-purple-200">
              <div className="size-12 bg-purple-600 rounded-lg flex items-center justify-center mb-4">
                <Eye className="size-6 text-white" />
              </div>
              <h3 className="font-bold text-lg mb-2">Lesson Observations</h3>
              <p className="text-slate-600 text-sm">Summary of teaching quality assessments and classroom evaluations</p>
            </div>

            <div className="bg-gradient-to-br from-green-50 to-green-100 rounded-xl p-6 border-2 border-green-200">
              <div className="size-12 bg-green-600 rounded-lg flex items-center justify-center mb-4">
                <BarChart2 className="size-6 text-white" />
              </div>
              <h3 className="font-bold text-lg mb-2">Access Data</h3>
              <p className="text-slate-600 text-sm">Student enrollment and educational access metrics across regions</p>
            </div>

            <div className="bg-gradient-to-br from-indigo-50 to-indigo-100 rounded-xl p-6 border-2 border-indigo-200">
              <div className="size-12 bg-indigo-600 rounded-lg flex items-center justify-center mb-4">
                <UsersRound className="size-6 text-white" />
              </div>
              <h3 className="font-bold text-lg mb-2">VLC Attendance</h3>
              <p className="text-slate-600 text-sm">Virtual Learning Community participation and digital engagement rates</p>
            </div>

            <div className="bg-gradient-to-br from-orange-50 to-orange-100 rounded-xl p-6 border-2 border-orange-200">
              <div className="size-12 bg-orange-600 rounded-lg flex items-center justify-center mb-4">
                <Tablet className="size-6 text-white" />
              </div>
              <h3 className="font-bold text-lg mb-2">Tablet Distribution</h3>
              <p className="text-slate-600 text-sm">Digital device deployment progress across all secondary schools</p>
            </div>

            <div className="bg-gradient-to-br from-cyan-50 to-cyan-100 rounded-xl p-6 border-2 border-cyan-200">
              <div className="size-12 bg-cyan-600 rounded-lg flex items-center justify-center mb-4">
                <FileText className="size-6 text-white" />
              </div>
              <h3 className="font-bold text-lg mb-2">Transcript Portal</h3>
              <p className="text-slate-600 text-sm">Student transcript portal completion rates and digital record adoption</p>
            </div>

            <div className="bg-gradient-to-br from-pink-50 to-pink-100 rounded-xl p-6 border-2 border-pink-200">
              <div className="size-12 bg-pink-600 rounded-lg flex items-center justify-center mb-4">
                <Heart className="size-6 text-white" />
              </div>
              <h3 className="font-bold text-lg mb-2">Guidance & Counselling</h3>
              <p className="text-slate-600 text-sm">Student support services availability and counselling program tracking</p>
            </div>

            <div className="bg-gradient-to-br from-teal-50 to-teal-100 rounded-xl p-6 border-2 border-teal-200">
              <div className="size-12 bg-teal-600 rounded-lg flex items-center justify-center mb-4">
                <Laptop className="size-6 text-white" />
              </div>
              <h3 className="font-bold text-lg mb-2">ICT Integration</h3>
              <p className="text-slate-600 text-sm">Technology integration levels and digital literacy progress in SHS</p>
            </div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="relative py-32 overflow-hidden">
        <div className="absolute inset-0 bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900"></div>
        <div className="absolute inset-0 opacity-10">
          <div className="absolute top-0 left-0 w-96 h-96 bg-red-600 rounded-full blur-3xl"></div>
          <div className="absolute bottom-0 right-0 w-96 h-96 bg-yellow-500 rounded-full blur-3xl"></div>
          <div className="absolute top-1/2 left-1/2 w-96 h-96 bg-green-600 rounded-full blur-3xl"></div>
        </div>
        <div className="relative z-10 max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h2 className="text-4xl md:text-5xl font-bold text-white mb-6">
            Access the Dashboard Now
          </h2>
          <p className="text-xl text-slate-300 mb-10 max-w-2xl mx-auto">
            Join educators, policymakers, and stakeholders across Ghana in using data to transform our secondary education system
          </p>
          <Button 
            size="lg"
            className="bg-yellow-500 hover:bg-yellow-600 text-black text-lg px-10 py-6 h-auto font-bold"
            asChild
          >
            <a href={dashboardUrl} target="_blank" rel="noopener noreferrer">
              Launch Dashboard
            </a>
          </Button>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-slate-900 text-slate-400 py-12 border-t border-slate-800">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <div className="mb-6">
            <div className="text-xl font-bold text-white mb-2">Ghana Secondary Education Reform Dashboard</div>
            <p className="text-sm">Empowering education through data and transparency</p>
          </div>
          <div className="text-sm text-slate-500">
            © 2026 Ghana Education Service. Supporting Ghana's Vision for Quality Secondary Education.
          </div>
        </div>
      </footer>
    </div>
  );
}